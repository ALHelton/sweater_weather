require "rails_helper"

RSpec.describe TeleportService do
  describe "city_salaries", :vcr do
    let(:service) { TeleportService.new.city_salaries("aarhus") }

    it "establishes a connection to get forcast by coordinates" do
      expect(service).to be_a(Hash)
      expect(service.keys).to eq([:_links, :salaries])
      
      expect(service[:_links]).to be_a(Hash)
      expect(service[:_links][:curies]).to be_an(Array)
      expect(service[:_links][:curies][0]).to be_a(Hash)
      expect(service[:_links][:curies][0]).to have_key(:name)
      expect(service[:_links][:curies][0][:name]).to be_a(String)

      expect(service[:salaries]).to be_an(Array)
      expect(service[:salaries][0]).to be_a(Hash)
      expect(service[:salaries][0].keys).to eq([:job, :salary_percentiles])
      expect(service[:salaries][0][:job]).to be_a(Hash)
      expect(service[:salaries][0][:job]).to have_key(:title)
      expect(service[:salaries][0][:job][:title]).to be_a(String)

      expect(service[:salaries][0][:salary_percentiles]).to be_a(Hash)
      expect(service[:salaries][0][:salary_percentiles]).to have_key(:percentile_25)
      expect(service[:salaries][0][:salary_percentiles]).to have_key(:percentile_25)
      expect(service[:salaries][0][:salary_percentiles][:percentile_25]).to be_a(Float)
      expect(service[:salaries][0][:salary_percentiles]).to have_key(:percentile_75)
      expect(service[:salaries][0][:salary_percentiles][:percentile_75]).to be_a(Float)
    end
  end
end
