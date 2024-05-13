require "yellin/engine"
require "yellin/acts_as_user"

module Yellin
  mattr_accessor :app_name, :default_from_address, :flash, :password_minimum_length, :reset_timeout_minutes, :user_class

  def self.app_name
    @@app_name || Rails.application.class.parent
  end

  def self.default_from_address
    @@default_from_address || 'noreply@exmaple.com'
  end

  def self.flash
    default_flash = {
      account_inactive: "Account not activated. Check your email for the activation link.",
      activation_invalid: "Invalid activation link.",
      activation_pending: "Please check your email to activate your account.",
      activation_success: "Account activated.",
      bad_credentials: "Invalid email/password combination.",
      reset_expired: "Password reset has expired.",
      reset_invalid: "Email address not found.",
      reset_sent: "Email sent with password reset instructions.",
      reset_success: "Your password has been reset.",
      sign_in_required: "Please sign in.",
      sign_in_success: "Signed in successfully.",
    }
    @@flash || default_flash
  end

  def self.password_minimum_length
    @@password_minimum_length || 12
  end

  def self.reset_timeout_minutes
    @@reset_timeout_minutes || 20
  end

  def self.user_class
    @@user_class.constantize
  end

end
