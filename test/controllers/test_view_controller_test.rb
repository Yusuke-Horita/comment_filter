require 'test_helper'

class TestViewControllerTest < ActionDispatch::IntegrationTest
  test "should get test_view" do
    get test_view_test_view_url
    assert_response :success
  end

end
