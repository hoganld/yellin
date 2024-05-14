require_dependency "yellin/application_controller"

module Yellin
  class SessionsController < ApplicationController

    def new
    end

    def create
      if user = Yellin.user_class.authenticate_by(email: params[:session][:email], password: params[:session][:password])
        sign_in(user)
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:notice] = Yellin.flash[:sign_in_success]
        redirect_back_or main_app.root_url
      else
        redirect_to sign_in_path(email_hint: params[:session][:email]), alert: Yellin.flash[:bad_credentials]
      end
    end

    def destroy
      sign_out if signed_in?
      redirect_to main_app.root_url
    end

    # def sign_out
    #   # Delete the current session
    #   @session = Current.session
    #   destroy
    # end

  end
end
