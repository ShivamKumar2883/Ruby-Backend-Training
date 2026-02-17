require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
  end

  test "should get show" do
    get store_show_url
    assert_response :success
  end

  test "should get create" do
    get store_create_url
    assert_response :success
  end

  test "should get update" do
    get store_update_url
    assert_response :success
  end

  test "should get delete" do
    get store_delete_url
    assert_response :success
  end
end
