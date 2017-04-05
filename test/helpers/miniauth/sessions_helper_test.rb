require 'test_helper'

module Briscoe
  class SessionsHelperTest < ActionView::TestCase
    def setup
      @user = test_users(:one)
      remember(@user)
    end

    test "current_user returns right user when session is nil" do
      assert_equal @user, current_user
      assert is_logged_in?
    end

    test "current_user returns nil when remember digest is wrong" do
      @user.update_attribute(:remember_digest, TestUser.digest(TestUser.new_token))
      assert_nil current_user
    end
  end
end
