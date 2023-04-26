require "rails_helper"

RSpec.describe MapQuestService do
  describe "get_address_lat_long", :vcr do
    let(:service) { MapQuestService.new.get_address_lat_long("Denver, CO") }

    it "establishes connection to get coordinates for a city & state" do
      expect(service).to be_a(Hash)
      expect(service.keys).to eq([:lat, :lng])
      expect(service[:lat]).to be_a(Float)
      expect(service[:lng]).to be_a(Float)
    end
  end

  describe "get_travel_time", :vcr do
    let(:service) { MapQuestService.new.get_travel_time("Cincinatti, OH", "Chicaco, IL") }

    it "establishes connection to get travel time between 2 locations" do
      expect(service).to be_a(Hash)
      expect(service).to have_key(:info)
      expect(service[:info]).to have_key(:statuscode)
      expect(service[:info][:statuscode]).to be_an(Integer)
      
      expect(service).to have_key(:route)
      expect(service[:route]).to be_a(Hash)
      expect(service[:route]).to have_key(:formattedTime)
      expect(service[:route][:formattedTime]).to be_a(String)
      expect(service[:route]).to have_key(:realTime)
      expect(service[:route][:realTime]).to be_an(Integer)
    end
  end
end