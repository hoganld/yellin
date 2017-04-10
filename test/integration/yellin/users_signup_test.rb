require 'test_helper'

module Yellin
  class UsersSignupTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
      ActionMailer::Base.deliveries.clear
    end

    test "invalid signup info" do
      get signup_path
      assert_no_difference "TestUser.count" do
        post signup_path, params: { test_user: { email: 'user@invalid.com' } }
      end
      assert_template "registrations/new"
      assert_select "div#error_explanation"
      assert_select "div.field_with_errors"
    end

    test "valid signup with account activation" do
      get signup_path
      assert_difference 'TestUser.count', 1 do
        post signup_path, params: { test_user: {email: 'user@example.com',
                                           password: 'ThinkingSiamese',
                                           password_confirmation: 'ThinkingSiamese' } }
      end
      assert_equal 1, ActionMailer::Base.deliveries.size
      user = assigns(:user)
      assert_not user.activated?
      log_in_as user
      assert_not is_logged_in?
      get edit_account_activation_path("invalid token", email: user.email)
      assert_not is_logged_in?
      get edit_account_activation_path(user.activation_token, email: 'wrong again')
      assert_not is_logged_in?
      get edit_account_activation_path(user.activation_token, email: user.email)
      assert user.reload.activated?
      follow_redirect!
      assert_template "static_pages/home"
      assert is_logged_in?
    end
  end
end
