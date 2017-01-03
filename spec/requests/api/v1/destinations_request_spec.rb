require 'rails_helper'

describe "destinations endpoints" do
  context "GET /destinations" do
    it "returns a list of all destinations" do
      destination_1 = Destination.create(name: "Denver", zip: "80246", description: "great city", image_url: "https://placehold.it/300x300.png/000")
      destination_2 = Destination.create(name: "Kansas City", zip: "66215", description: "nice city", image_url: "https://placehold.it/300x300.png/000")

      get "/api/v1/destinations"

      destinations = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(destinations.count).to eq(2)
      expect(destinations.first[:name]).to eq(destination_1.name)
      expect(destinations.last[:name]).to eq(destination_2.name)
    end
  end
end
