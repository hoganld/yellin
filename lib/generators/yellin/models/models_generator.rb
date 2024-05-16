module Yellin
  module Generators
    class ModelsGenerator < Rails::Generators::Base

      def generate_all_models
        invoke "yellin:models:users"
      end
    end
  end

  module Models
    module Generators
      class BaseModelGenerator < Rails::Generators::NamedBase
        include Rails::Generators::Migration
      
        def self.next_migration_number(n)
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        end
        
        def generate_model
          preexisting_model = (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?)
          if preexisting_model
            migration_template "migration_update_#{migration_class_name}.rb", "db/migrate/add_yellin_to_#{table_name}.rb"
          else
            migration_template "migration_create_#{migration_class_name}.rb", "db/migrate/yellin_create_#{table_name}.rb"
            invoke "active_record:model", [name], migration: false
          end
          yellinize_model unless behavior == :revoke
        end

        # def generate_model
        #   yellinize_model if behavior == :revoke
        #   unless @preexisting_model
        #     invoke "active_record:model", [name], migration: false
        #   end
        #   yellinize_model if behavior == :invoke
        # end

        private
        def model_exists?
          File.exist? File.join(destination_root, "app/models/", "#{file_name}.rb")
        end

        def migration_exists?
          pattern = File.join(destination_root, "db/migrate", "*_add_yellin_to_#{table_name}.rb")
          Dir.glob(pattern).first
        end
        
      end
    end
  end
end
