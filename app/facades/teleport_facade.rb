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
        formatted_min = format("%.2f", salary[:salary_percentiles][:percentile_25])
        formatted_max = format("%.2f", salary[:salary_percentiles][:percentile_75])


        {
          title: salary[:job][:title],
          min: "$#{formatted_min.gsub(/(\d)(?=\d{3}+(\.\d*)?$)/, '\\1,')}",
          max: "$#{formatted_max.gsub(/(\d)(?=\d{3}+(\.\d*)?$)/, '\\1,')}"
        }
      end
    end.compact

    Salary.new(destination, forecast, salaries)
  end
end