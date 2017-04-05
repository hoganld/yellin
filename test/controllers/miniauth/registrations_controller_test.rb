require 'test_helper'

module Briscoe
  class RegistrationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
    end

    test "should get new" do
      get signup_path
      assert_response :success
    end

    # test "the truth" do
    #   assert true
    # end
  end
end
