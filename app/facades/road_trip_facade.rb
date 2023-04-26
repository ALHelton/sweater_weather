class RoadTripFacade

  def trip_info(start_point, end_point)
    service = MapQuestService.new.get_travel_time(start_point, end_point)
    weather_info = WeatherFacade.new.forecast_json(end_point)
    
    start_city = start_point
    end_city = end_point
    travel_time = "impossible route"
    weather_at_eta = {}
    
    if service[:info][:statuscode] == 0
      time_array = service[:route][:formattedTime].split(":")
      arrival_datetime = (Time.now + service[:route][:time]).to_s
      datetime_segments = arrival_datetime.split(" ")
      time_segments = datetime_segments[1].split(":")
      arrival_time = "#{time_segments[0]}:#{time_segments[1]}"
      hours = "#{time_array[0].to_i}h"
      minutes = "#{time_array[1].to_i}m"

      found_arrival_day = weather_info[:forecast][:forecastday].find do |day|
        arrival_datetime.include?(day[:date])
      end

      if found_arrival_day
        time = found_arrival_day[:hour].each do |hour|
          hour if hour.include?(arrival_time)
        end

        travel_time = hours + minutes

        weather_at_eta = {
          datetime: arrival_datetime[0..-7],
          temperature: "#{time[0][:temp_f]}F",
          condition: time[0][:condition][:text]
        }
      end
    end

    RoadTrip.new(start_city, end_city, travel_time, weather_at_eta)
  end
end