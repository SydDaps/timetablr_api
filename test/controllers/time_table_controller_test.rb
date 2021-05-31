require "test_helper"

class TimeTableControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get time_table_create_url
    assert_response :success
  end

  test "should get index" do
    get time_table_index_url
    assert_response :success
  end
end
