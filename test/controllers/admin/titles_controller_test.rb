require 'test_helper'

class Admin::TitlesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_titles_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_titles_update_url
    assert_response :success
  end

  test "should get delete" do
    get admin_titles_delete_url
    assert_response :success
  end
end
