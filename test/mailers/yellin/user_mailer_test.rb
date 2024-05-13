require 'test_helper'

module Yellin
  class UserMailerTest < ActionMailer::TestCase
    test "password_reset" do
      user = test_users(:one)
      token = user.generate_token_for :password_reset
      mail = UserMailer.password_reset(user, token)
      assert_equal "Password reset", mail.subject
      assert_equal [user.email], mail.to
      assert_equal ["#{Yellin.default_from_address}"], mail.from
      assert_match "Password reset", mail.body.encoded
      assert_match CGI.escape(token), mail.body.encoded
    end
  end
end
