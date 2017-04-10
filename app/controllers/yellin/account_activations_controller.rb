require_dependency "yellin/application_controller"

module Yellin
  class AccountActivationsController < ApplicationController

    def edit
      @user = Yellin.user_class.find_by(email: params[:email])
      if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
        @user.activate
        log_in @user
        flash[:success] = Yellin.flash[:activation_success]
        begin
          redirect_to @user
        rescue NoMethodError
          redirect_to main_app.root_url
        end
      else
        flash[:danger] = Yellin.flash[:activation_invalid]
        redirect_to main_app.root_url
      end
    end

  end
end
