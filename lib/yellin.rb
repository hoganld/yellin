require "yellin/engine"
require "yellin/acts_as_user"

module Yellin
  mattr_accessor :app_name, :default_from_address, :flash, :password_minimum_length, :reset_timeout_hours, :user_class

  def self.app_name
    @@app_name || Rails.application.class.parent
  end

  def self.default_from_address
    @@default_from_address || 'noreply@exmaple.com'
  end

  def self.flash
    default_flash = {
      account_inactive: "Account not activated. Check your email for the activation link.",
      activation_pending: "Please check your email to activate your account.",
      activation_success: "Account activated.",
      activation_invalid: "Invalid activation link.",
      bad_credentials: "Invalid email/password combination.",
      login_required: "Please sign in.",
      reset_sent: "Email sent with password reset instructions.",
      reset_success: "Your password has been reset.",
      reset_expired: "Password reset has expired.",
    }
    @@flash || default_flash
  end

  def self.password_minimum_length
    @@password_minimum_length || 12
  end

  def self.reset_timeout_hours
    @@reset_timeout_hours || 2
  end

  def self.user_class
    @@user_class.constantize
  end

end
