require 'test_helper'

class TestUserTest < ActiveSupport::TestCase
  def setup
    @user = TestUser.new(email: "user@example.com",password: 'ThinkSiamese', password_confirmation: 'ThinkSiamese')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = ''
    assert_not @user.valid?
  end

  test "email should be no more than 255 characters" do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    addresses = %w[user@example.com user.name@example.com USER@example.COM THE_user@ex.ample.com user+name@example.com]
    addresses.each do |a|
      @user.email = a
      assert @user.valid?, "#{a.inspect} should be valid"
    end
  end

  test "email validation should require @ sign" do
    @user.email = 'userATexample.com'
    assert_not @user.valid?
  end

  test "email address should be unique" do
    other_user = @user.dup
    other_user.email.upcase!
    @user.save
    assert_not other_user.valid?
  end

  test "email should be downcased on save" do
    @user.email = 'USER@EXAMPLE.COM'
    @user.save
    assert @user.email == 'user@example.com'
  end

  test "email should be stripped of whitespace" do
    @user.email = " user@example.com "
    @user.save
    assert @user.email == "user@example.com"
  end

  test "password required" do
    @user.password = nil
    assert_not @user.valid?
  end

  test "password must be at least 12 characters" do
    @user.password = @user.password_confirmation = 'Chihuahua'
    assert_not @user.valid?
  end

  test "remember should set remember_digest" do
    assert_not @user.remember_digest
    @user.remember
    assert @user.remember_digest
  end

  test "authenticated? should return false for a user with a nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "should be inactive by default" do
    assert_not @user.activated?
  end

end
