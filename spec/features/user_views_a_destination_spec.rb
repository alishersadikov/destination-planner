require 'rails_helper'

feature "user clicks a specific destination" do
  it "sees destination info and 10 day weather forecast" do

    destination = Destination.create(
                              name: "Denver", zip: "80246", description: "great city",
                              image_url: "www.denver.com/picture.jpg")
    visit "/"

    expect(page).to have_content(destination.name)
  end
end


# As a user
# When I visit "/"
# And I click on a destination
# Then I should be on page "/destinations/:id"
# Then I should see the destination's name, zipcode, description, and 10 day weather forecast
# The weather forecast is specific to the destination whose page I'm on
# The forecast should include date (weekday, month and day), high and low temps (F), and weather conditions
