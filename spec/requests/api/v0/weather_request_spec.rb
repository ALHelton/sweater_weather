require "rails_helper"

RSpec.describe "Weather Request" do
  describe "GET location forecast" do
    it "gets a forecast for a given location parameter", :vcr do
      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }

      get "/api/v0/forecast?location=cincinatti,oh"
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(parsed[:data]).to be_a(Hash)
      expect(parsed[:data].keys).to eq([:id, :type, :attributes])
      expect(parsed[:data][:id]).to eq(nil)
      expect(parsed[:data][:type]).to eq("forecast")
      expect(parsed[:data][:attributes]).to be_a(Hash)
      expect(parsed[:data][:attributes].keys).to eq([
                                                    :current_weather, 
                                                    :daily_weather, 
                                                    :hourly_weather
                                                    ])

      expect(parsed[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(parsed[:data][:attributes][:current_weather].keys).to eq([
                                                                      :last_updated, 
                                                                      :temperature, 
                                                                      :feels_like, 
                                                                      :humidity, 
                                                                      :uvi,
                                                                      :visibility,
                                                                      :condition,
                                                                      :icon
                                                                      ])

      expect(parsed[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(parsed[:data][:attributes][:daily_weather][0]).to be_a(Hash)
      expect(parsed[:data][:attributes][:daily_weather][0].keys).to eq([
                                                                    :date,
                                                                    :sunrise,
                                                                    :sunset,
                                                                    :max_temp,
                                                                    :min_temp,
                                                                    :day_condition,
                                                                    :day_icon
                                                                    ])

      expect(parsed[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(parsed[:data][:attributes][:hourly_weather][0]).to be_a(Hash)
      expect(parsed[:data][:attributes][:hourly_weather][0].keys).to eq([
                                                                    :time,
                                                                    :temperature,
                                                                    :conditions,
                                                                    :icon
                                                                    ])
    end
  end
end