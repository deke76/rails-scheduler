require "application_system_test_case"

class IceTimesTest < ApplicationSystemTestCase
  setup do
    @ice_time = ice_times(:one)
  end

  test "visiting the index" do
    visit ice_times_url
    assert_selector "h1", text: "Ice times"
  end

  test "should create ice time" do
    visit ice_times_url
    click_on "New ice time"

    fill_in "Day", with: @ice_time.day
    fill_in "Start time", with: @ice_time.start_time
    fill_in "Length", with: @ice_time.length
    fill_in "Team", with: @ice_time.team_id
    click_on "Create Ice time"

    assert_text "Ice time was successfully created"
    click_on "Back"
  end

  test "should update Ice time" do
    visit ice_time_url(@ice_time)
    click_on "Edit this ice time", match: :first

    fill_in "Day", with: @ice_time.day
    fill_in "Start time", with: @ice_time.start_time
    fill_in "Length", with: @ice_time.length
    fill_in "Team", with: @ice_time.team_id
    click_on "Update Ice time"

    assert_text "Ice time was successfully updated"
    click_on "Back"
  end

  test "should destroy Ice time" do
    visit ice_time_url(@ice_time)
    click_on "Destroy this ice time", match: :first

    assert_text "Ice time was successfully destroyed"
  end
end
