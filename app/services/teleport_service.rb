class TeleportService

  def city_salaries(city)
    response = connection.get("urban_areas/slug:#{city}/salaries")
    JSON.parse(response.body, symbolize_names: true)
  end
  
  private
  def connection
    Faraday.new("https://api.teleport.org/api/")
  end
end