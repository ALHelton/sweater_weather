require "rails_helper"

RSpec.describe "Session Request" do
  before do
    @headers = {
      "Content-Type" => "application/json",
      "Accept" => "application/json"
    }

    @user_params = {
      "email": "whatever@example.com",
      "password": "password"
    }

    @user = User.create!(
                        email: "whatever@example.com", 
                        password: "password", 
                        password_confirmation: "password")
  end

  describe "Login User" do
    context "when successful" do
      it "logs in an existing user and returns an api key" do
        post "/api/v0/sessions", headers: @headers, params: @user_params.to_json
        parsed = JSON.parse(response.body, symbolize_names: true)


        expect(response.status).to eq(200)
        expect(parsed).to have_key(:data)
        expect(parsed[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed[:data][:id]).to be_a(String)
        expect(parsed[:data][:type]).to be_a(String)
        expect(parsed[:data][:type]).to eq("session")
        expect(parsed[:data][:attributes]).to be_a(Hash)
        expect(parsed[:data][:attributes].keys).to eq([:email, :api_key])
        expect(parsed[:data][:attributes]).to_not have_key(:password)
        expect(parsed[:data][:attributes][:email]).to be_a(String)
        expect(parsed[:data][:attributes][:api_key]).to be_a(String)
      end
    end
  end
end
