class MapQuestService

  def get_address_lat_long(params)
    response = connection.get("/geocoding/v1/address?location=#{params}")
    JSON.parse(response.body, symbolize_names: true)[:results][0][:locations][0][:latLng]
  end

  def get_travel_time(start_point, end_point)
    response = connection.get("/directions/v2/route?from=#{start_point}&to=#{end_point}")
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  def connection
    Faraday.new("https://www.mapquestapi.com") do |f|
      f.params["key"] = ENV["mapq_key"]
    end
  end
end

# https://www.mapquestapi.com/geocoding/v1/address?key=KEY&location=Washington,DC

