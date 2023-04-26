require "rails_helper"

RSpec.describe Forecast do
  let(:forecast) { WeatherFacade.new.full_forecast("Denver, CO") }
  before do
    @current_keys = [
      :last_updated, 
      :temperature, 
      :feels_like, 
      :humidity, 
      :uvi, 
      :visibility, 
      :condition, 
      :icon
    ]

    @daily_keys = [
      :date,
      :sunrise,
      :sunset,
      :max_temp,
      :min_temp,
      :day_condition,
      :day_icon
    ]

    @hourly_keys = [
      :time,
      :temperature,
      :conditions,
      :icon
    ]
  end
  
  it "Creates an object for a forecast", :vcr do
    expect(forecast.id).to be(nil)
    expect(forecast.current_weather).to be_a(Hash)

    expect(forecast.daily_weather).to be_an(Array)
    expect(forecast.daily_weather.first).to be_a(Hash)
    
    expect(forecast.hourly_weather).to be_an(Array)
    expect(forecast.hourly_weather.first).to be_a(Hash)

    expect(forecast.current_weather.keys).to eq(@current_keys)
    expect(forecast.current_weather.keys.size).to eq(@current_keys.size)

    expect(forecast.daily_weather.first.keys).to eq(@daily_keys)
    expect(forecast.daily_weather.first.keys.size).to eq(@daily_keys.size)

    expect(forecast.hourly_weather.first.keys).to eq(@hourly_keys)
    expect(forecast.hourly_weather.first.keys.size).to eq(@hourly_keys.size)
  end
end