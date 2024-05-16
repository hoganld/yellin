module Yellin
  module Models
    module Generators
      class UsersGenerator < BaseModelGenerator
        source_root File.expand_path("templates", __dir__)

        def debugger
          say "Class name: #{class_name}"
        end

        private
        # def name
        #   Yellin.user_class.name
        # end
        
        def class_name
          name
        end

        def file_name
          table_name.singularize
        end

        def table_name
          class_name.tableize
        end

        def migration_class_name
          "users"
        end

        def inject_yellin
        end

        def yellinize_model
          # Avoid subtracting from non-existent file
          say "Yellinizing"
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
