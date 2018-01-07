require 'test_helper'

class StrategiesControllerTest < ActionDispatch::IntegrationTest
  test "should get timing" do
    get strategies_timing_url
    assert_response :success
  end

  test "should get momentum" do
    get strategies_momentum_url
    assert_response :success
  end

end
