require "rails_helper"

RSpec.describe TeleportFacade do
  describe "get_city_salaries", :vcr do
    let(:salary) { TeleportFacade.new.get_city_salaries("chicago") }

    it "creates a poros for salary info by city" do

      specific_titles = [
        "Data Analyst", 
        "Data Scientist", 
        "Mobile Developer", 
        "QA Engineer",
        "Software Engineer",
        "Systems Administrator",
        "Web Developer"
      ]

      expect(salary).to be_a(Salary)
      expect(salary.destination).to be_a(String)
      expect(salary.forecast).to be_a(Hash)
      expect(salary.forecast.keys).to eq([:summary, :temperature])
      expect(salary.forecast[:summary]).to be_a(String)
      expect(salary.forecast[:temperature]).to be_a(String)
      expect(salary.id).to eq(nil)
      expect(salary.salaries).to be_an(Array)
      expect(salary.salaries.size).to eq(7)


      salary.salaries.each do |job|
        expect(job).to be_a(Hash)
        expect(job.keys).to eq([:title, :min, :max])
        expect(job[:title]).to be_a(String)
        expect(specific_titles).to include(job[:title])
        expect(job[:min]).to be_a(String)
        expect(job[:max]).to be_a(String)
      end
    end
  end
end