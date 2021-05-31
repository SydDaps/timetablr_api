require "test_helper"

class Api::V1::CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_courses_create_url
    assert_response :success
  end

  test "should get index" do
    get api_v1_courses_index_url
    assert_response :success
  end
end
