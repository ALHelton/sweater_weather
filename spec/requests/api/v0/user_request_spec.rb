require "rails_helper"

RSpec.describe "user Request" do
  before do
    @headers = {
      "Content-Type" => "application/json",
      "Accept" => "application/json"
    }

    @user_params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
  end

  describe "Create User" do
    context "when successful" do
      it "creates a new user with a key", :vcr do
        post "/api/v0/users", headers: @headers, params: @user_params.to_json
        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(201)
        expect(parsed).to have_key(:data)
        expect(parsed[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed[:data][:id]).to be_a(String)
        expect(parsed[:data][:type]).to be_a(String)
        expect(parsed[:data][:type]).to eq("user")
        expect(parsed[:data][:attributes]).to be_a(Hash)
        expect(parsed[:data][:attributes].keys).to eq([:email, :api_key])
        expect(parsed[:data][:attributes]).to_not have_key(:password)
        expect(parsed[:data][:attributes][:email]).to be_a(String)
        expect(parsed[:data][:attributes][:api_key]).to be_a(String)
      end
    end
  end
end