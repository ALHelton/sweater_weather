require "rails_helper"

RSpec.describe RoadTripFacade do
  describe "trip_info", :vcr do
    let(:road_trip) { RoadTripFacade.new.trip_info("Cincinatti, OH", "Chicaco, IL") }

    it "creates a poros for road trip info by start & end location" do
      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.id).to eq(nil)
      expect(road_trip.start_city).to eq("Cincinatti, OH")
      expect(road_trip.end_city).to eq("Chicaco, IL")
      expect(road_trip.travel_time).to be_a(String)
      expect(road_trip.weather_at_eta).to be_a(Hash)
      expect(road_trip.weather_at_eta.keys).to eq([:datetime, :temperature, :condition])
      expect(road_trip.weather_at_eta[:datetime]).to be_a(String)
      expect(road_trip.weather_at_eta[:temperature]).to be_a(String)
      expect(road_trip.weather_at_eta[:condition]).to be_a(String)
    end
  end
end