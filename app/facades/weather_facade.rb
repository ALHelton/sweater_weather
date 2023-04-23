class WeatherFacade
  def initialize
    @service = WeatherService.new
  end
  
  def forecast_json(lat, long)
    @service.fiveday_forecast_coords(lat, long)
  end

  def current_weather(lat, long)
    CurrentWeather.new(forecast_json(lat, long)[:current])
  end

  def daily_weather(lat, long)
    json = forecast_json(lat, long)[:forecast][:forecastday]
    json.map do |day|
      DailyWeather.new(day)
    end
  end

  def hourly_weather(lat, long)
    days = forecast_json(lat, long)[:forecast][:forecastday]
    days.first[:hour][-12, 8].map do |hour|
      HourlyWeather.new(hour)
    end
  end

  def full_forecast(lat, long)
    current = current_weather(lat, long)
    daily = daily_weather(lat, long)
    hourly = hourly_weather(lat, long)

    Forecast.new(current, daily, hourly)
  end
end