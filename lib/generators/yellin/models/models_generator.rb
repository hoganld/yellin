module Yellin
  module Generators
    module ModelsGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      def check_preexistence
        @preexisting_model = (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?)
      end

      def generate_migration
        if @preexisting_model
          migration_template "migration_update_#{table_name}.rb", "db/migrate/add_yellin_to_#{table_name}.rb"
        else
          migration_template "migration_create_#{table_name}.rb", "db/migrate/yellin_create_#{table_name}.rb"
        end
      end

      def generate_model
        yellinize_model if behavior == :revoke
        unless @preexisting_model
          invoke "active_record:model", [name], migration: false
        end
        yellinize_model if behavior == :invoke
      end

      private
      def model_exists?
        File.exist? File.join(destination_root, "app/models", "#{file_name}.rb")
      end

      def migration_exists?
        pattern = File.join(destination_root, "db/migrate", "*_add_yellin_to_#{table_name}.rb")
        Dir.glob(pattern).first
      end

      def yellinize_model
        # Avoid subtracting from non-existent file
        if model_exists?
          inject_into_file "app/models/#{file_name}.rb", after: "class #{class_name} < ApplicationRecord\n" do <<-YELLIN
  include Yellin::ActsAsUser
  acts_as_user
         YELLIN
          end
        end
      end
    end
  end
end