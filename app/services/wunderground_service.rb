class WundergroundService
  attr_reader :conn, :zipcode

  def initialize(zipcode)
    @zipcode = zipcode[0..4]
    @conn = connection
  end

  def forecasts_by_zipcode
    response = conn.get("#{ENV["api_key"]}/forecast10day/q/#{zipcode}.json")
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    parsed_response[:forecast][:simpleforecast][:forecastday]
  end

  private
    def connection
     Faraday.new(url: "http://api.wunderground.com/api/") do |faraday|
       faraday.adapter Faraday.default_adapter
     end
    end
end
