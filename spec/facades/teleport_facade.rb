require "rails_helper"

RSpec.describe TeleportFacade do
  describe "get_city_salaries", :vcr do
    let(:salaries) { TeleportFacade.new.get_city_salaries("chicago") }

    it "creates a poros for salary info by city" do

      expect(salaries.first).to be_a(Salary)

    end
  end
end