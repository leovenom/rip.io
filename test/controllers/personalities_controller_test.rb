require 'test_helper'

class PersonalitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get personalities_index_url
    assert_response :success
  end

  test "should get show" do
    get personalities_show_url
    assert_response :success
  end

  test "should get create" do
    get personalities_create_url
    assert_response :success
  end

end
