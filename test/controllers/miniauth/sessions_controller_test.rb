require 'test_helper'

module Miniauth
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
    end

    test "should get new" do
      get login_path
      assert_response :success
      assert_select "h1", "Sign in"
    end
  end
end
