require 'test_helper'

module Briscoe
  class UserMailerTest < ActionMailer::TestCase
    test "account_activation" do
      user = test_users(:one)
      user.activation_token = Briscoe.user_class.new_token
      mail = UserMailer.account_activation(user)
      assert_equal "Account activation", mail.subject
      assert_equal [user.email], mail.to
      assert_equal ["#{Briscoe.default_from_address}"], mail.from
      assert_match "Welcome to #{Briscoe.app_name}", mail.body.encoded
      assert_match user.activation_token, mail.body.encoded
      assert_match CGI.escape(user.email), mail.body.encoded
    end

    test "password_reset" do
      user = test_users(:one)
      user.reset_token = Briscoe.user_class.new_token
      mail = UserMailer.password_reset(user)
      assert_equal "Password reset", mail.subject
      assert_equal [user.email], mail.to
      assert_equal ["#{Briscoe.default_from_address}"], mail.from
      assert_match "Password reset", mail.body.encoded
      assert_match user.reset_token, mail.body.encoded
      assert_match CGI.escape(user.email), mail.body.encoded
    end
  end
end
