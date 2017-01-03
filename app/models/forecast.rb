class Forecast
  attr_reader :date, :high, :low, :conditions

  def initialize(raw_data)
    @date = raw_data[:date][:monthname] + " " + raw_data[:date][:day].to_s + ", " + raw_data[:date][:year].to_s
    @high = raw_data[:high][:fahrenheit]
    @low = raw_data[:low][:fahrenheit]
    @conditions = raw_data[:conditions]
  end

  def self.build_forecasts(zipcode)
    raw_forecasts = WundergroundService.new(zipcode).forecasts_by_zipcode
    raw_forecasts.map do |forecast|
      Forecast.new(forecast)
    end
  end
end
