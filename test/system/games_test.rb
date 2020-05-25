require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end
  test "Going to /new gives us a new random grid to play with" do
    visit root_url
    assert test: "New Game"
    assert_selector "div", count: 12
  end

  test "Non valid english word raises an invalid message" do
    visit root_url
    fill_in "user_input", with: "jkl"
    click_on "Play"

    assert_text "Sorry but JKL does not seem to be a valid English word..."
  end

  test "Valid english word that doesn't belong to grid should raise invalid message" do
    visit root_url
    fill_in "user_input", with: "perpetuity"
    click_on "Play"

    assert_text "Sorry but PERPETUITY can't be built out of"
  end
end
