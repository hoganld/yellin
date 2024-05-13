require_dependency "yellin/application_controller"

module Yellin
  class PasswordResetsController < ApplicationController
    before_action :get_user, only: [:edit, :update]

    def new
    end

    def create
      @user = Yellin.user_class.find_by(email: params[:password_reset][:email].downcase)
      if @user
        token = @user.generate_token_for :password_reset
        @user.send_password_reset_email(token)
        redirect_to main_app.root_url, notice: Yellin.flash[:reset_sent]
      else
        flash.now[:danger] = Yellin.flash[:reset_invalid]
        render 'new'
      end
    end

    def edit
    end

    def update
      if params[:user][:password].empty?
        @user.errors.add(:password, "can't be empty")
        render 'edit'
      elsif @user.reset_password(user_params)
        redirect_to sign_in_path, notice: Yellin.flash[:reset_success]
      else
        render 'edit'
      end
    end

    private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = Yellin.user_class.find_by_token_for!(:password_reset, params[:sid])
    rescue
      redirect_to new_password_reset_url
    end

  end
end
