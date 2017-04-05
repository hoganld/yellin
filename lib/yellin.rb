require "yellin/engine"
require "yellin/acts_as_user"

module Yellin
  mattr_accessor :user_class, :default_from_address, :app_name

  def self.user_class
    @@user_class.constantize
  end

  def self.default_from_address
    @@default_from_address || 'noreply@exmaple.com'
  end

  def self.app_name
    @@app_name || Rails.application.class.parent
  end

end
