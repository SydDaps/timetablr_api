require "test_helper"

class Api::V1ControllerTest < ActionDispatch::IntegrationTest
  test "should get rooms" do
    get api_v1_rooms_url
    assert_response :success
  end
end
