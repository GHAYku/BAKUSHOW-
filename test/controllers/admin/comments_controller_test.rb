require 'test_helper'

class Admin::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_comments_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_comments_update_url
    assert_response :success
  end

  test "should get delete" do
    get admin_comments_delete_url
    assert_response :success
  end

end
