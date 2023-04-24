class WeatherFacade
  def forecast_json(location)
    coords = MapQuestFacade.new.get_coords(location)
    service = WeatherService.new
    service.fiveday_forecast_coords(coords[:lat], coords[:lng])
  end

  def full_forecast(location)
    current = forecast_json(location)[:current]
    days = forecast_json(location)[:forecast][:forecastday]
    hours = forecast_json(location)[:forecast][:forecastday].first[:hour]

    current_weather = {
      last_updated: current[:last_updated],
      temperature: current[:temp_f],
      feels_like: current[:feelslike_f],
      humidity: current[:humidity],
      uvi: current[:uv],
      visibility: current[:vis_miles],
      condition: current[:condition][:text],
      icon: current[:condition][:icon]
    }

    daily_weather = days.map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:min_temp],
        day_condition: day[:day][:condition][:text],
        day_icon: day[:day][:condition][:icon]
      }
    end

    hourly_weather = hours[-12, 8].map do |hour|
      {
        time: hour[:time],
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end

    Forecast.new(current_weather, daily_weather, hourly_weather)
  end
end