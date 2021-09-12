require 'test_helper'

class Admin::EndUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_end_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_end_users_update_url
    assert_response :success
  end

  test "should get delete" do
    get admin_end_users_delete_url
    assert_response :success
  end

end
