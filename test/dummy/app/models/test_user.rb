class TestUser < ApplicationRecord
  include Yellin::ActsAsUser

  acts_as_user
end
