class MapQuestService

  def get_address_lat_long(params)
    response = connection.get("/geocoding/v1/address?location=#{params}")
    JSON.parse(response.body, symbolize_names: true)[:results][0][:locations][0][:latLng]
  end

  private
  def connection
    Faraday.new("https://www.mapquestapi.com") do |f|
      f.params["key"] = ENV["mapq_key"]
    end
  end
end

# https://www.mapquestapi.com/geocoding/v1/address?key=KEY&location=Washington,DC

