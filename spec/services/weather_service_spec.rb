require "rails_helper"

RSpec.describe WeatherService do
  describe "get_forcast_by_coordinates" do
    let(:service) { WeatherService.new.fiveday_forecast_coords("39.742043", "-104.991531") }

    before do
      VCR.use_cassette("WeatherService") do
        service
      end
    end

    it "establishes a connection to get forcast by coordinates" do
      expect(service).to be_a(Hash)
      expect(service.keys).to eq([:location, :current, :forecast])

      expect(service[:location]).to be_a(Hash)
      expect(service[:location]).to have_key(:name)
      expect(service[:location][:name]).to be_a(String)
      expect(service[:location][:name]).to eq("Denver")
      expect(service[:location]).to have_key(:region)
      expect(service[:location][:region]).to be_a(String)
      expect(service[:location]).to have_key(:country)
      expect(service[:location][:country]).to be_a(String)

      expect(service[:current]).to be_a(Hash)
      expect(service[:current].keys).to eq([:last_updated, :temp_f, :condition, :humidity, :feelslike_f, :vis_miles, :uv])
      expect(service[:current][:last_updated]).to be_a(String)
      expect(service[:current][:temp_f]).to be_a(Float)
      expect(service[:current][:condition]).to be_a(Hash)
      expect(service[:current][:condition].keys).to eq([:text, :icon])
      expect(service[:current][:condition][:text]).to be_a(String)
      expect(service[:current][:condition][:icon]).to be_a(String)
      expect(service[:current][:humidity]).to be_an(Integer)
      expect(service[:current][:feelslike_f]).to be_a(Float)
      expect(service[:current][:vis_miles]).to be_a(Float)
      expect(service[:current][:uv]).to be_a(Float)

      expect(service[:forecast]).to be_a(Hash)
      expect(service[:forecast][:forecastday]).to be_an(Array)
      expect(service[:forecast][:forecastday].size).to eq(5)

      expect(service[:forecast][:forecastday][0]).to be_a(Hash)
      expect(service[:forecast][:forecastday][0].keys).to eq([:date, :day, :astro, :hour])
      expect(service[:forecast][:forecastday][0][:date]).to be_a(String)
      expect(service[:forecast][:forecastday][0][:day]).to be_a(Hash)
      expect(service[:forecast][:forecastday][0][:day]).to have_key(:maxtemp_f)
      expect(service[:forecast][:forecastday][0][:day][:maxtemp_f]).to be_a(Float)
      expect(service[:forecast][:forecastday][0][:day]).to have_key(:mintemp_f)
      expect(service[:forecast][:forecastday][0][:day][:mintemp_f]).to be_a(Float)
      expect(service[:forecast][:forecastday][0][:day]).to have_key(:condition)
      expect(service[:forecast][:forecastday][0][:day][:condition]).to be_a(Hash)
      expect(service[:forecast][:forecastday][0][:day][:condition].keys).to eq([:text, :icon])
      expect(service[:forecast][:forecastday][0][:day][:condition][:text]).to be_a(String)
      expect(service[:forecast][:forecastday][0][:day][:condition][:icon]).to be_a(String)

      expect(service[:forecast][:forecastday][0][:astro]).to be_a(Hash)
      expect(service[:forecast][:forecastday][0][:astro]).to have_key(:sunrise)
      expect(service[:forecast][:forecastday][0][:astro][:sunrise]).to be_a(String)
      expect(service[:forecast][:forecastday][0][:astro]).to have_key(:sunset)
      expect(service[:forecast][:forecastday][0][:astro][:sunset]).to be_a(String)

      expect(service[:forecast][:forecastday][0][:hour]).to be_an(Array)
      expect(service[:forecast][:forecastday][0][:hour][0]).to be_a(Hash)
      expect(service[:forecast][:forecastday][0][:hour][0].keys).to eq([:time, :temp_f, :condition])

      expect(service[:forecast][:forecastday][0][:hour][0][:time]).to be_a(String)
      expect(service[:forecast][:forecastday][0][:hour][0][:temp_f]).to be_a(Float)
      expect(service[:forecast][:forecastday][0][:hour][0][:condition]).to be_a(Hash)

      expect(service[:forecast][:forecastday][0][:hour][0][:condition].keys).to eq([:text, :icon])
      expect(service[:forecast][:forecastday][0][:hour][0][:condition][:text]).to be_a(String)
      expect(service[:forecast][:forecastday][0][:hour][0][:condition][:icon]).to be_a(String)
    end
  end
end