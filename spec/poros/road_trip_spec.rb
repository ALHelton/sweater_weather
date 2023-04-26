require "rails_helper"

RSpec.describe RoadTrip do
  let(:road_trip) { RoadTripFacade.new.trip_info("Cincinatti, OH", "Chicaco, IL") }

  it "Creates an object for a road_trip", :vcr do
    expect(road_trip.id).to be(nil)
    expect(road_trip.start_city).to be_a(String)
    expect(road_trip.end_city).to be_a(String)
    expect(road_trip.travel_time).to be_a(String)
    expect(road_trip.weather_at_eta).to be_a(Hash)
    expect(road_trip.weather_at_eta.keys).to eq([:datetime, :temperature, :condition])
    expect(road_trip.weather_at_eta[:datetime]).to be_a(String)
    expect(road_trip.weather_at_eta[:temperature]).to be_a(String)
    expect(road_trip.weather_at_eta[:condition]).to be_a(String)
  end
end