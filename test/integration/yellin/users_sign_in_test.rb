require 'test_helper'

module Yellin
  class UsersSignInTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
      @user = test_users(:one)
    end

    test "invalid sign in info displays error message" do
      post sign_in_path, params: { session: { email: 'user@example.com', password: '' } }
      follow_redirect!
      assert_not flash.empty?
    end

    test "sign in with valid information followed by sign out" do
      get sign_in_path
      post sign_in_path, params: { session: { email: @user.email, password: 'ThinkSiamese' } }
      follow_redirect!
      assert is_signed_in?
      assert_select 'a[href=?]', sign_in_path, count: 0
      assert_select 'a[href=?]', sign_out_path
      delete sign_out_path
      assert_not is_signed_in?
      assert_redirected_to root_url
      # simulate user clicking sign out in a second window
      delete sign_out_path
      follow_redirect!
      assert_select 'a[href=?]', sign_in_path
      assert_select 'a[href=?]', sign_out_path, count: 0
    end

    test "sign in with remembering" do
      sign_in_as(@user, remember_me: '1')
      assert_not_empty cookies['remember_token']
    end

    test "sign in without remembering" do
      sign_in_as(@user, remember_me: '1')
      sign_in_as(@user, remember_me: '0')
      assert_empty cookies['remember_token']
    end
  end
end
