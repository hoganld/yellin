require 'test_helper'

module Yellin
  class UsersLoginTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
      @user = test_users(:one)
    end

    test "invalid login info displays error message" do
      get login_path
      post login_path, params: { session: { email: 'user@example.com', password: '' } }
      assert_not flash.empty?
      get login_path
      assert flash.empty?
    end

    test "login with valid information followed by logout" do
      get login_path
      post login_path, params: { session: { email: @user.email, password: 'ThinkSiamese' } }
      follow_redirect!
      assert is_logged_in?
      assert_select 'a[href=?]', login_path, count: 0
      assert_select 'a[href=?]', logout_path
      delete logout_path
      assert_not is_logged_in?
      assert_redirected_to root_url
      # simulate user clicking logout in a second window
      delete logout_path
      follow_redirect!
      assert_select 'a[href=?]', login_path
      assert_select 'a[href=?]', logout_path, count: 0
    end

    test "login with remembering" do
      log_in_as(@user, remember_me: '1')
      assert_equal cookies['remember_token'], assigns(:user).remember_token
      assert_not_empty cookies['remember_token']
    end

    test "login without remembering" do
      log_in_as(@user, remember_me: '1')
      log_in_as(@user, remember_me: '0')
      assert_empty cookies['remember_token']
    end
  end
end
