class Forecast
  attr_reader :date, :high, :low, :conditions

  def initialize(raw_data)
    @date = raw_data[:date][:monthname] + " " + raw_data[:date][:day].to_s + ", " + raw_data[:date][:year].to_s
    @high = raw_data[:high][:fahrenheit]
    @low = raw_data[:low][:fahrenheit]
    @conditions = raw_data[:conditions]
  end
end
