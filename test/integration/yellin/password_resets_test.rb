require 'test_helper'

module Yellin
  class PasswordResetsTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
      ActionMailer::Base.deliveries.clear
      @user = test_users(:one)
    end

    test "password resets" do
      get new_password_reset_path
      assert_template "password_resets/new"
      # Invalid email
      post password_resets_path, params: { password_reset: { email: '' } }
      assert_redirected_to root_url
      # Valid email
      post password_resets_path, params: { password_reset: { email: @user.email } }
      assert_not_equal @user.reset_digest, @user.reload.reset_digest
      assert_equal ActionMailer::Base.deliveries.size, 1
      assert_not flash.empty?
      assert_redirected_to root_url
      # Password reset form
      user = assigns(:user)
      # Wrong email
      get edit_password_reset_path(user.reset_token, email: "")
      assert_redirected_to root_url
      # Inactive user
      user.toggle!(:activated)
      get edit_password_reset_path(user.reset_token, email: user.email)
      assert_redirected_to root_url
      user.toggle!(:activated)
      # Right email, wrong token
      get edit_password_reset_path("wrong token", email: user.email)
      assert_redirected_to root_url
      # Right email, expired token
      user.update_attribute(:reset_sent_at, 3.hours.ago)
      get edit_password_reset_path(user.reset_token, email: user.email)
      assert_not flash.empty?
      assert_redirected_to new_password_reset_path
      # Right email, right token
      user.update_attribute(:reset_sent_at, 1.hours.ago)
      get edit_password_reset_path(user.reset_token, email: user.email)
      assert_template "password_resets/edit"
      assert_select "input[name=email][type=hidden][value=?]", user.email
      # Invalid password & confirmation
      params = { email: user.email, user: {password: 'ThinkSiamese', password_confirmation: 'ThinkChihuahua' }}
      patch password_reset_path(user.reset_token, params: params)
      assert_select "div#error_explanation"
      # Empty password
      params = { email: user.email, user: {password: '', password_confirmation: '' }}
      patch password_reset_path(user.reset_token, params: params)
      assert_select "div#error_explanation"
      # Valid password & confirmation
      params = { email: user.email, user: {password: 'ThinkChihuahua', password_confirmation: 'ThinkChihuahua' }}
      patch password_reset_path(user.reset_token, params: params)
      assert_nil user.reload.reset_digest
      assert_not is_logged_in?
      assert_not flash.empty?
      assert_redirected_to login_path
    end
  end
end
