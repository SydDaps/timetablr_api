require "test_helper"

class Api::V1::UserControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get api_v1_user_register_url
    assert_response :success
  end
end
