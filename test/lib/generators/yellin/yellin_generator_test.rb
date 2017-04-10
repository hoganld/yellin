require 'test_helper'
require 'generators/yellin/yellin_generator'
require 'fileutils'

module Yellin
  class YellinGeneratorTest < Rails::Generators::TestCase
    tests YellinGenerator
    destination Rails.root.join('tmp/generators')
    setup do
      prepare_destination
      prepare_app
    end

    def prepare_app
      root_dir = Rails.root.join("tmp/generators")
      config_dir = File.join(root_dir, "config")
      FileUtils.mkdir_p(config_dir)
      File.open(File.join(config_dir, 'routes.rb'), 'w') do |f|
        f.write <<~ROUTES
        Rails.application.routes.draw do
        end
        ROUTES
      end
    end

    test "generator runs without errors" do
      assert_nothing_raised do
        run_generator ["User"]
      end
    end

    test "generator creates initializer file" do
      run_generator ["User"]
      assert_file "config/initializers/yellin.rb" do |init|
        assert_match(/Yellin.app_name = Dummy/, init)
        assert_match(/Yellin.flash/, init)
        assert_match(/reset_success: \"Your password has been reset.\"/, init)
        assert_match(/Yellin.password_minimum_length = 12/, init)
        assert_match(/Yellin.user_class = \"User\"/, init)
      end
    end

    test "generator mounts engine routes" do
      run_generator ["User"]
      assert_file "config/routes.rb" do |routes|
        assert_match(/mount Yellin::Engine => '\/'/, routes)
      end
    end
  end
end
