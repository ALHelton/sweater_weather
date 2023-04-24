require "rails_helper"

RSpec.describe Salary do
    let(:salary) { TeleportFacade.new.get_city_salaries("chicago") }

  it "Creates an object for a salary", :vcr do
    expect(salary.id).to be(nil)
    expect(salary.destination).to be_a(String)
    expect(salary.forecast).to be_a(Hash)
    expect(salary.salaries).to be_an(Array)

    expect(salary.forecast.keys).to eq([:summary, :temperature])
    expect(salary.forecast[:summary]).to be_a(String)
    expect(salary.forecast[:temperature]).to be_a(String)

    salary.salaries.each do |job|
      expect(job.keys).to eq([:title, :min, :max])
      expect(job[:title]).to be_a(String)
      expect(job[:min]).to be_a(String)
      expect(job[:max]).to be_a(String)
    end
  end
end