require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get find_videos" do
    get search_find_videos_url
    assert_response :success
  end

end
