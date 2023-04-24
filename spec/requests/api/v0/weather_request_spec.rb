require "rails_helper"

RSpec.describe "Weather Request" do
  describe "GET location forecast" do
    it "gets a forecast for a given location parameter", :vcr do
      # headers = {
      #   "Content-Type" => "application/json",
      #   "Accept" => "application/json"
      # }

      get "/api/v0/forecast?location=cincinatti,oh"
      expect(response).to be_successful
    end
  end
end