require "rails_helper"

RSpec.describe "Salaries Request" do
  describe "GET location salaries" do
    it "gets salary information for a given location parameter", :vcr do
      get "/api/v1/salaries?destination=chicago"
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful

      specific_titles = [
        "Data Analyst", 
        "Data Scientist", 
        "Mobile Developer", 
        "QA Engineer",
        "Software Engineer",
        "Systems Administrator",
        "Web Developer"
      ]

      expect(parsed[:data]).to be_a(Hash)
      expect(parsed[:data].keys).to eq([:id, :type, :attributes])
      expect(parsed[:data][:type]).to eq("salaries")
      expect(parsed[:data][:attributes]).to be_a(Hash)
      expect(parsed[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])

      expect(parsed[:data][:attributes][:destination]).to be_a(String)
      expect(parsed[:data][:attributes][:forecast]).to be_a(Hash)
      expect(parsed[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
      expect(parsed[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(parsed[:data][:attributes][:forecast][:temperature]).to be_a(String)

      expect(parsed[:data][:attributes][:salaries]).to be_an(Array)
      expect(parsed[:data][:attributes][:salaries].size).to eq(7)
      expect(parsed[:data][:attributes][:salaries].size).to eq(7)

      parsed[:data][:attributes][:salaries].each do |job|
        expect(specific_titles).to include(job[:title])
      end
      
      expect(parsed[:data][:attributes][:salaries].first).to be_a(Hash)
      expect(parsed[:data][:attributes][:salaries].first.keys).to eq([:title, :min, :max])

      expect(parsed[:data][:attributes][:salaries].first[:title]).to be_a(String)
      expect(parsed[:data][:attributes][:salaries].first[:min]).to be_a(String)
      expect(parsed[:data][:attributes][:salaries].first[:max]).to be_a(String)
    end
  end
end