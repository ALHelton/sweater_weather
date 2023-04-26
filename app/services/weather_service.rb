class WeatherService

  def fiveday_forecast_coords(lat, long)
    response = connection.get("/v1/forecast.json?q=#{lat},#{long}&days=5")
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  def connection
    Faraday.new("http://api.weatherapi.com") do |f|
      f.params["key"] = ENV["wthr_key"]
    end
  end
end