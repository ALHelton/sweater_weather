class CurrentWeather
  attr_reader :last_updated,
              :current_temp,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :current_condition,
              :current_icon

  def initialize(info)
    @last_updated = info[:last_updated]
    @current_temp = info[:temp_f]
    @feels_like = info[:feelslike_f]
    @humidity = info[:humidity]
    @uvi = info[:uv]
    @visibility = info[:vis_miles]
    @current_condition = info[:condition][:text]
    @current_icon = info[:condition][:icon]
  end
end