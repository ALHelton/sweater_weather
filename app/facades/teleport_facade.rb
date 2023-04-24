class TeleportFacade

  def initialize
    @service = TeleportService.new
  end

  def get_city_salaries(city)
    all_salaries = @service.city_salaries(city)[:salaries]
    entire_forecast = WeatherFacade.new.full_forecast(city)

    destination = "#{city}"

    forecast = {
      summary: entire_forecast.hourly_weather.first[:conditions],
      temperature: "#{entire_forecast.current_weather[:temperature]} F"
    }
    require 'pry'; binding.pry

    salaries = all_salaries.map do |salary|
      {
        title: salary[:job][:title],
        min: sprintf("$%.2f", salary[:salary_percentiles][:percentile_25], delimeter: ","),
        max: sprintf("$%.2f", salary[:salary_percentiles][:percentile_75], delimeter: ",")
      }
    end

    Salary.new(destination, forecast, salaries)
  end
end