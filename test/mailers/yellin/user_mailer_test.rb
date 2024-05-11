require 'test_helper'

module Yellin
  class UserMailerTest < ActionMailer::TestCase
    test "password_reset" do
      user = test_users(:one)
      user.reset_token = Yellin.user_class.new_token
      mail = UserMailer.password_reset(user)
      assert_equal "Password reset", mail.subject
      assert_equal [user.email], mail.to
      assert_equal ["#{Yellin.default_from_address}"], mail.from
      assert_match "Password reset", mail.body.encoded
      assert_match user.reset_token, mail.body.encoded
      assert_match CGI.escape(user.email), mail.body.encoded
    end
  end
end
