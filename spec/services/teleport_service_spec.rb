require "rails_helper"

RSpec.describe TeleportService do
  describe "city_salaries", :vcr do
    let(:service) { TeleportService.new.city_salaries("aarhus") }

    it "establishes a connection to get forcast by coordinates" do
      expect(service).to be_a(Hash)
      require 'pry'; binding.pry
    end
  end
end
