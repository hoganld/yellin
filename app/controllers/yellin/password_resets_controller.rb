require_dependency "yellin/application_controller"

module Yellin
  class PasswordResetsController < ApplicationController
    before_action :get_user, only: [:edit, :update]
    before_action :valid_user, only: [:edit, :update]
    before_action :check_expiration, only: [:edit, :update]

    def new
    end

    def create
      @user = Yellin.user_class.find_by(email: params[:password_reset][:email].downcase)
      if @user
        @user.create_reset_digest
        @user.send_password_reset_email
      end
      flash[:info] = Yellin.flash[:reset_sent]
      redirect_to main_app.root_url
    end

    def edit
    end

    def update
      if params[:user][:password].empty?
        @user.errors.add(:password, "can't be empty")
        render 'edit'
      elsif @user.reset_password(user_params)
        flash[:success] = Yellin.flash[:reset_success]
        redirect_to login_path
      else
        render 'edit'
      end
    end

    private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = Yellin.user_class.find_by(email: params[:email])
    end

    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        redirect_to main_app.root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = Yellin.flash[:reset_expired]
        redirect_to new_password_reset_url
      end
    end
  end
end
