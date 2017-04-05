require_dependency "yellin/application_controller"

module Yellin
  class SessionsController < ApplicationController

    def create
      @user = Yellin.user_class.find_by(email: params[:session][:email].downcase)
      if @user && @user.authenticate(params[:session][:password])
        if @user.activated?
          log_in(@user)
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          after_create
        else
          flash[:warning] = "Account not activated. Check your email for the activation link."
          redirect_to main_app.root_url
        end
      else
        flash.now[:danger] = "Invalid email/password combination."
        render 'new'
      end
    end

    def destroy
      log_out if logged_in?
      redirect_to main_app.root_url
    end

    def new
    end

    def after_create
      begin
        redirect_back_or @user
      rescue NoMethodError
        redirect_to main_app.root_url
      end
    end

  end
end
