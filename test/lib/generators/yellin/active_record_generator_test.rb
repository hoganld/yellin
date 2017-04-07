require 'test_helper'
require 'generators/active_record/yellin_generator'
require 'fileutils'

module ActiveRecord
  class YellinGeneratorTest < Rails::Generators::TestCase
    tests ActiveRecord::Generators::YellinGenerator
    destination Rails.root.join('tmp/generators')

    setup do
      prepare_destination
      prepare_app
    end


    def prepare_app
      root_dir = Rails.root.join("tmp/generators")
      models_dir = File.join(root_dir, "app/models")
      FileUtils.mkdir_p(models_dir)
      File.open(File.join(models_dir, 'application_record.rb'), 'w') do |f|
        f.write <<~MODEL
        class ApplicationRecord < ActiveRecord::Base
          self.abstract_class = true
        end
        MODEL
      end
    end

    test "generator creates model if not exists" do
      run_generator ["User"]
      assert_file "app/models/user.rb" do |model|
        assert_match("include Yellin::ActsAsUser", model)
        assert_match("acts_as_user", model)
      end
    end

    test "generator updates model if file exists" do
      create_dummy_model
      run_generator ["User"]
      assert_file "app/models/user.rb" do |model|
        assert_match("include Yellin::ActsAsUser", model)
        assert_match("acts_as_user", model)
      end
    end

    test "generator creates table for new model" do
      run_generator ["User"]
      assert_migration "db/migrate/yellin_create_users.rb" do |migration|
        assert_match("create_table :users", migration)
      end
    end

    test "generator updates table for existing model" do
      create_dummy_model
      run_generator ["User"]
      assert_migration "db/migrate/add_yellin_to_users.rb" do |migration|
        assert_match("change_table :users", migration)
      end
    end

    private
    def create_dummy_model
      dir = Rails.root.join('tmp/generators/app/models')
      FileUtils.mkdir_p(dir)
      File.open(File.join(dir, 'user.rb'), 'w') do |f|
        f.write <<~MODEL
        class User < ApplicationRecord
        end
        MODEL
      end
    end

  end
end
