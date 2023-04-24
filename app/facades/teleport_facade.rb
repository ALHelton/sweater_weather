class TeleportFacade

  def initialize
    @service = TeleportService.new
  end

  def get_city_salaries(city)
    all_salaries = @service.city_salaries(city)[:salaries]

    destination = "#{city}"

    salaries = all_salaries.map do |salary|
      {
        title: salary[:job][:title],
        min: sprintf("$%.2f", salary[:salary_percentiles][:percentile_25], delimeter: ",")
        max: sprintf("$%.2f", salary[:salary_percentiles][:percentile_75], delimeter: ",")
      }
    end
  end
end