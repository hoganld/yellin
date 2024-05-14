module Yellin
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def copy_initializer_file
        template "initializer.rb", "config/initializers/yellin.rb"
      end

      def mount_engine
        route "mount Yellin::Engine => '/'"
      end

    end
  end
end

