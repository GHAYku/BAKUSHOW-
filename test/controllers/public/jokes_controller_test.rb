require 'test_helper'

class Public::JokesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_jokes_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_jokes_edit_url
    assert_response :success
  end

  test "should get new" do
    get public_jokes_new_url
    assert_response :success
  end

  test "should get show" do
    get public_jokes_show_url
    assert_response :success
  end
end
