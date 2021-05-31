require "test_helper"

class Api::V1::AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test "should get authenticate" do
    get api_v1_authentication_authenticate_url
    assert_response :success
  end
end
