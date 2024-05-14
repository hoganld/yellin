require 'rails/generators/active_record'

# This generator is bad. It is inheriting from an undocumented internal-only rails API.
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
        # yellinize_user_model if behavior == :revoke
        unless @preexisting_model
          invoke "active_record:model", [name], migration: false
        end
        # yellinize_user_model if behavior == :invoke
      end

      private
      def yellinize_user_model
        # Avoid subtracting from non-existent file
        if model_exists?
          inject_into_file "app/models/#{file_name}.rb", after: "class #{class_name} < ApplicationRecord\n" do <<-YELLIN
  include Yellin::ActsAsUser
  acts_as_user
         YELLIN
          end
        end
      end

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
