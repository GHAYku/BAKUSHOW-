require 'test_helper'

class Public::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get public_homes_top_url
    assert_response :success
  end

  test "should get home" do
    get public_homes_home_url
    assert_response :success
  end

  test "should get new" do
    get public_homes_new_url
    assert_response :success
  end

  test "should get popular" do
    get public_homes_popular_url
    assert_response :success
  end

  test "should get about" do
    get public_homes_about_url
    assert_response :success
  end
end
