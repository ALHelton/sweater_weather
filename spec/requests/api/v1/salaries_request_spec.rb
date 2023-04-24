require "rails_helper"

RSpec.describe "Salaries Request" do
  describe "GET location salaries" do
    it "gets salary information for a given location parameter", :vcr do
      get "/api/v1/salaries?destination=chicago"
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      # require 'pry'; binding.pry
      expect(parsed[:data]).to be_a(Hash)
      expect(parsed[:data].keys).to eq([:id, :type, :attributes])

    end
  end
end