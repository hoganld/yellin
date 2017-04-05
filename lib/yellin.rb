require "yellin/engine"
require "yellin/acts_as_user"

module Yellin
  # VERSION = '0.1.0'
  mattr_accessor :user_class, :default_from_address, :app_name

  def self.user_class
    @@user_class.constantize
  end
end
