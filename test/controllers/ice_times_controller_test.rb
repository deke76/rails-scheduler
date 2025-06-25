require "test_helper"

class IceTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ice_time = ice_times(:one)
  end

  test "should get index" do
    get ice_times_url
    assert_response :success
  end

  test "should get new" do
    get new_ice_time_url
    assert_response :success
  end

  test "should create ice_time" do
    assert_difference("IceTime.count") do
      post ice_times_url, params: { ice_time: { day: @ice_time.day, start_time: @ice_time.start_time, length: @ice_time.length, team_id: @ice_time.team_id } }
    end

    assert_redirected_to ice_time_url(IceTime.last)
  end

  test "should show ice_time" do
    get ice_time_url(@ice_time)
    assert_response :success
  end

  test "should get edit" do
    get edit_ice_time_url(@ice_time)
    assert_response :success
  end

  test "should update ice_time" do
    patch ice_time_url(@ice_time), params: { ice_time: { day: @ice_time.day, start_time: @ice_time.start_time, length: @ice_time.length, team_id: @ice_time.team_id } }
    assert_redirected_to ice_time_url(@ice_time)
  end

  test "should destroy ice_time" do
    assert_difference("IceTime.count", -1) do
      delete ice_time_url(@ice_time)
    end

    assert_redirected_to ice_times_url
  end
end
