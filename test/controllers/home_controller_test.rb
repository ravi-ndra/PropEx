require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get guest" do
    get home_guest_url
    assert_response :success
  end
end
