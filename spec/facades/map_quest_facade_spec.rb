require "rails_helper"

RSpec.describe MapQuestFacade do
  describe "get_coords", :vcr do
    let(:coords) { MapQuestFacade.new.get_coords("Denver, CO") }
   
    it "gets coordinate info for a given location" do
      expect(coords[:lat]).to be_a(Float)
      expect(coords[:lng]).to be_a(Float)
    end
  end
end