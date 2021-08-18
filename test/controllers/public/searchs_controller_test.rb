require 'test_helper'

class Public::SearchsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_searchs_new_url
    assert_response :success
  end

  test "should get search" do
    get public_searchs_search_url
    assert_response :success
  end

end
