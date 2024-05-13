module Yellin
  class UserMailer < ApplicationMailer
    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.user_mailer.password_reset.subject
    #
    def password_reset(user, token)
      @token = token
      mail to: user.email, subject: 'Password reset'
    end
  end
end
