require_dependency "yellin/application_controller"

module Yellin
  class RegistrationsController < ApplicationController

    def create
      @user = Yellin.user_class.new(signup_params)
      if @user.save
        @user.send_activation_email
        flash[:info] = Yellin.flash[:activation_pending]
        redirect_to main_app.root_url
      else
        render 'new'
      end
    end

    def new
      @user = Yellin.user_class.new
    end

    private
    def signup_params
      user_key = Yellin.user_class.model_name.param_key
      params.require(user_key).permit(:email, :password, :password_confirmation)
    end
  end
end
