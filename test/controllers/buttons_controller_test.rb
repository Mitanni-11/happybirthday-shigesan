require 'test_helper'

class ButtonsControllerTest < ActionDispatch::IntegrationTest
  test "should get share" do
    get buttons_share_url
    assert_response :success
  end

  test "should get first" do
    get buttons_first_url
    assert_response :success
  end

end
