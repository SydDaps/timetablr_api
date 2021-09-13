require "test_helper"

class Api::V1::StudentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_students_create_url
    assert_response :success
  end
end
