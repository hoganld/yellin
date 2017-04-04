require_dependency "miniauth/application_controller"

module Miniauth
  class RegistrationsController < ApplicationController
    REGISTRATION_MESSAGE = "Please check your email to activate your account."

    def create
      @user = Miniauth.user_class.new(signup_params)
      if @user.save
        @user.send_activation_email
        flash[:info] = REGISTRATION_MESSAGE
        after_create
      else
        render 'new'
      end
    end

    def new
      @user = Miniauth.user_class.new
    end

    def after_create
      redirect_to main_app.root_url
    end

    private
    def signup_params
      user_key = Miniauth.user_class.model_name.param_key
      params.require(user_key).permit(:email, :password, :password_confirmation)
    end
  end
end
