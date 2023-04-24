class TeleportFacade

  def initialize
    @service = TeleportService.new
  end

  def get_city_salaries(city)
    city_names = @service.city_salaries(city)
    require 'pry'; binding.pry

    destination = city_names[:name]
  end
end