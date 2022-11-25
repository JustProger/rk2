require "test_helper"

class RkmainControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get rkmain_input_url
    assert_response :success
  end

  test "should get show" do
    get rkmain_show_url
    assert_response :success
  end
end
