class TeleportFacade

  def initialize
    @service = TeleportService.new
  end

  def get_city_salaries(city)
    all_salaries = @service.city_salaries(city)[:salaries]
    entire_forecast = WeatherFacade.new.full_forecast(city)
    specific_titles = [
                      "Data Analyst", 
                      "Data Scientist", 
                      "Mobile Developer", 
                      "QA Engineer",
                      "Software Engineer",
                      "Systems Administrator",
                      "Web Developer"
    ]

    destination = "#{city}"

    forecast = {
      summary: entire_forecast.hourly_weather.first[:conditions],
      temperature: "#{entire_forecast.current_weather[:temperature]} F"
    }

    salaries = all_salaries.map do |salary|
      if specific_titles.include?("#{salary[:job][:title]}")
        {
          title: salary[:job][:title],
          min: sprintf("$%.2f", salary[:salary_percentiles][:percentile_25], delimeter: ","),
          max: sprintf("$%.2f", salary[:salary_percentiles][:percentile_75], delimeter: ",")
        }
      end
    end.compact

    Salary.new(destination, forecast, salaries)
  end
end