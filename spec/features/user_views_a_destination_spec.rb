require 'rails_helper'

feature "user clicks a specific destination" do
  it "sees destination info and 10 day weather forecast" do
    VCR.use_cassette("forecasts") do

      destination = Destination.create(
                                name: "Denver", zip: "80246", description: "great city",
                                image_url: "https://placehold.it/300x300.png/000")
      visit "/"

      expect(page).to have_content(destination.name)

      find(:xpath, "//a/img[@alt='000']/..").click

      expect(current_path).to eq(destination_path(destination))

      expect(page).to have_content(destination.name)
      expect(page).to have_content(destination.zip)
      expect(page).to have_content(destination.description)

      expect(page).to have_content(Time.now.strftime("%B %-d, %Y"))
      expect(page).to have_content("52")
      expect(page).to have_content("18")
      expect(page).to have_content("Partly Cloudy")
      expect(page).to have_content("January 11, 2017")
      expect(page).to have_content("46")
      expect(page).to have_content("28")
      expect(page).to have_content("Clear")
    end
  end
end

# /html/body/div/img
# <img src="https://placehold.it/300x300.png/000" alt="000">
# As a user
# When I visit "/"
# And I click on a destination
# Then I should be on page "/destinations/:id"
# Then I should see the destination's name, zipcode, description, and 10 day weather forecast
# The weather forecast is specific to the destination whose page I'm on
# The forecast should include date (weekday, month and day), high and low temps (F), and weather conditions
