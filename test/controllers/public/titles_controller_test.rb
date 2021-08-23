require 'test_helper'

class Public::TitlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_titles_index_url
    assert_response :success
  end

  test "should get new" do
    get public_titles_new_url
    assert_response :success
  end

  test "should get show" do
    get public_titles_show_url
    assert_response :success
  end
end
