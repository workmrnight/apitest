require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get list_show_url
    assert_response :success
  end

end
