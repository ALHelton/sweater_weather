class WeatherFacade
  def initialize
    @service = WeatherService.new
  end
  
  def forecast_json(location)
    coords = MapQuestFacade.new.get_coords(location)
    @service.fiveday_forecast_coords(coords[:lat], coords[:lng])
  end

  def current_weather(location)
    CurrentWeather.new(forecast_json(location)[:current])
  end

  def daily_weather(location)
    json = forecast_json(location)[:forecast][:forecastday]
    json.map do |day|
      DailyWeather.new(day)
    end
  end

  def hourly_weather(location)
    days = forecast_json(location)[:forecast][:forecastday]
    days.first[:hour][-12, 8].map do |hour|
      HourlyWeather.new(hour)
    end
  end

  def full_forecast(location)
    current = current_weather(location)
    daily = daily_weather(location)
    hourly = hourly_weather(location)

    Forecast.new(current, daily, hourly)
  end
end