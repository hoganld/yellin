require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class YellinGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def handle_migration
        @preexisting_model = (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?)
        if @preexisting_model
          migration_template "migration_update_#{table_name}.rb", "db/migrate/add_yellin_to_#{table_name}.rb"
        else
          migration_template "migration_create_#{table_name}.rb", "db/migrate/yellin_create_#{table_name}.rb"
        end
      end

      def handle_model
        unless @preexisting_model
          invoke "active_record:model", [name], migration: false
        end
      end

      private
      def model_exists?
        File.exist? File.join(destination_root, "app/models", "#{file_name}.rb")
      end

      def migration_exists?
        pattern = File.join(destination_root, "db/migrate", "*_add_yellin_to_#{table_name}.rb")
        Dir.glob(pattern).first
      end
    end
  end
end
