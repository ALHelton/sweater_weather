class MapQuestFacade
  def initialize
    @service = MapQuestService.new
  end

  def get_coords(location)
    @service.get_address_lat_long(location)
  end
end