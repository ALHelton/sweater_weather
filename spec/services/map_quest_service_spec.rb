require "rails_helper"

RSpec.describe MapQuestService do
  describe "get_address_lat_long" do
    let(:service) { MapQuestService.new.get_address_lat_long("Denver, CO") }

    before do
      VCR.use_cassette("MapQuestService") do
        service
      end
    end

    it "establishes connection to get coordinates for a city & state" do
      expect(service).to be_a(Hash)
      expect(service).to have_key(:results)
      expect(service[:results]).to be_an(Array)
      expect(service[:results][0]).to be_a(Hash)
      expect(service[:results][0]).to have_key(:locations)
      expect(service[:results][0][:locations]).to be_an(Array)
      expect(service[:results][0][:locations][0]).to be_a(Hash)
      expect(service[:results][0][:locations][0]).to have_key(:latLng)
      expect(service[:results][0][:locations][0][:latLng]).to be_a(Hash)
      expect(service[:results][0][:locations][0][:latLng].keys).to eq([:lat, :lng])
      expect(service[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
      expect(service[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
    end
  end
end