require "rails_helper"

RSpec.describe "Road Trip Request" do
  before do
    User.create!(email: "hello@hello.com", password: "123", password_confirmation: "123")

    @headers = {
      "Content-Type" => "application/json",
      "Accept" => "application/json"
    }

    @key = User.find_by(email: "hello@hello.com").api_key

    @trip_params = {
      origin: "Cincinatti,OH",
      destination: "Chicago,IL",
      api_key: @key
    }
  end

  describe "Create Road Trip", :vcr do
    context "when successful" do
      it "it creates road trip info from the origin and destination in the params" do
        post "/api/v0/road_trip", headers: @headers, params: @trip_params.to_json
        parsed = JSON.parse(response.body, symbolize_names: true)


        expect(response.status).to eq(201)

        expect(parsed).to have_key(:data)
        expect(parsed[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed[:data][:id]).to be(nil)
        expect(parsed[:data][:type]).to be_a(String)
        expect(parsed[:data][:type]).to eq("road_trip")
        expect(parsed[:data][:attributes]).to be_a(Hash)
        expect(parsed[:data][:attributes].keys).to eq([
                                                      :start_city,
                                                      :end_city, 
                                                      :travel_time, 
                                                      :weather_at_eta
                                                      ])

        expect(parsed[:data][:attributes][:start_city]).to be_a(String)
        expect(parsed[:data][:attributes][:end_city]).to be_a(String)
        expect(parsed[:data][:attributes][:travel_time]).to be_a(String)
        expect(parsed[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        expect(parsed[:data][:attributes][:weather_at_eta].keys).to eq([
                                                                        :datetime,
                                                                        :temperature,
                                                                        :condition
                                                                      ])
        
        expect(parsed[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
        expect(parsed[:data][:attributes][:weather_at_eta][:temperature]).to be_a(String)
        expect(parsed[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
      end

      it "creates a road trip with impossible info when given impossible route" do
        @trip_params[:origin] = "Tokyo, Japan"
        @trip_params[:destination] = "Rio de Janeiro, Brazil"
        post "/api/v0/road_trip", headers: @headers, params: @trip_params.to_json
        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(201)
        expect(parsed[:data][:attributes][:travel_time]).to eq("impossible route")
      end
    end

    context "when unsuccessful" do
      describe "it returns a 401 error" do
        it "if no API key is given" do
          @trip_params[:api_key] = nil
          post "/api/v0/road_trip", headers: @headers, params: @trip_params.to_json
          parsed = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(401)
          expect(parsed[:error]).to eq("Invalid Credentials")
        end

        it "if an incorrect key is provided" do
          @trip_params[:api_key] = "123abc"
          post "/api/v0/road_trip", headers: @headers, params: @trip_params.to_json
          parsed = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(401)
          expect(parsed[:error]).to eq("Invalid Credentials")
        end
      end
    end
  end
end