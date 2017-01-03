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

  context "GET /destinations/1" do
    it "returns the specific destination" do
      destination = Destination.create(name: "Denver", zip: "80246", description: "great city", image_url: "https://placehold.it/300x300.png/000")

      get "/api/v1/destinations/#{destination.id}"

      json_destination = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(json_destination[:name]).to eq(destination.name)
      expect(json_destination[:description]).to eq(destination.description)
    end
  end

  context "POST /destinations" do
    it "creates a destination" do
      headers = { "CONTENT-TYPE" => "application/json" }
      params = { name: "Phoenix", zip: "85001", description: "beautiful city", image_url: "https://placehold.it/300x300.png/000" }.to_json

      post "/api/v1/destinations", params, headers

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Destination.last.name).to eq("Phoenix")
      expect(result['name']).to eq("Phoenix")
      expect(result['image_url']).to eq("https://placehold.it/300x300.png/000")
      expect(result['zip']).to eq("85001")
      expect(result['description']).to eq("beautiful city")
    end
  end
  context "PUT /destinations/:id" do
    it "udpates a destination" do
      destination = Destination.create(name: "Phoenix", zip: "85001", description: "beautiful city", image_url: "https://placehold.it/300x300.png/000")

      headers = { "CONTENT-TYPE" => "application/json" }
      params = { name: "Kansas City", zip: "66204", description: "beautiful city", image_url: "https://placehold.it/300x300.png/000" }.to_json

      put "/api/v1/destinations/#{destination.id}", params, headers

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(Destination.last.name).to eq("Kansas City")
      expect(result['name']).to eq("Kansas City")
      expect(result['zip']).to eq("66204")
    end
  end

  context "DELETE /destinations/:id" do
    it "udpates a destination" do
      destination = Destination.create(name: "Phoenix", zip: "85001", description: "beautiful city", image_url: "https://placehold.it/300x300.png/000")

      expect(Destination.last.name).to eq("Phoenix")

      delete "/api/v1/destinations/#{destination.id}"

      expect(response).to be_success
      expect(Destination.find_by(name: "Phoenix")).to be_nil
    end
  end
end
