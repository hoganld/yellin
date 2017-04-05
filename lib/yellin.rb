require "yellin/engine"
require "yellin/acts_as_user"

module Yellin
  mattr_accessor :app_name, :default_from_address, :reset_timeout_hours, :user_class

  def self.app_name
    @@app_name || Rails.application.class.parent
  end

  def self.default_from_address
    @@default_from_address || 'noreply@exmaple.com'
  end

  def self.reset_timeout_hours
    @@reset_timeout_hours || 2
  end

  def self.user_class
    @@user_class.constantize
  end

end
