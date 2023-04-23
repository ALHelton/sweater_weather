require "rails_helper"

RSpec.describe WeatherFacade do
  describe "current", :vcr do
    let(:current) { WeatherFacade.new.current_weather("39.742043", "-104.991531") }
   
    it "creates a poros for current weather info by location" do
      expect(current).to be_a(CurrentWeather)
    end
  end

  describe "daily", :vcr do
    let(:days) { WeatherFacade.new.daily_weather("39.742043", "-104.991531") }
   
    it "creates a poros for daily weather info by location" do
      day = days.first
      expect(day).to be_a(DailyWeather)
    end
  end

  describe "hourly", :vcr do
    let(:hours) { WeatherFacade.new.hourly_weather("39.742043", "-104.991531") }
   
    it "creates a poros for hourly weather info by location" do
      hour = hours.first
      expect(hours.size).to eq(8)
      expect(hour).to be_an(HourlyWeather)
    end
  end

  describe "full_forecast", :vcr do
    let(:forecast) { WeatherFacade.new.full_forecast("39.742043", "-104.991531") }
  
    it "creates a poros for full forecast info by location" do
      expect(forecast).to be_a(Forecast)
    end
  end
end