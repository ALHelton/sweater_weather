class HourlyWeather
  attr_reader :time,
              :hour_temp,
              :hour_conditions,
              :hour_icon

  def initialize(info)
    @time = info[:time]
    @hour_temp = info[:temp_f]
    @hour_conditions = info[:condition][:text]
    @hour_icon = info[:condition][:icon]
  end
end