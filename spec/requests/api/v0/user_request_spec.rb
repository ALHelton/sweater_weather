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
      it "creates a new user with an api key" do
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

    context "when unsuccessful" do
      describe "it returns a 400 status code" do
        it "when password and pass confirmation don't match" do
          @user_params["password_confirmation"] = "notthepassword"
          post "/api/v0/users", headers: @headers, params: @user_params.to_json
          parsed = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(400)
          expect(parsed[:error]).to eq("Password confirmation doesn't match Password")
        end
        
        it "when email has been taken" do
          User.create!(email: "whatever@example.com", password: "123", password_confirmation: "123")

          post "/api/v0/users", headers: @headers, params: @user_params.to_json
          parsed = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(400)
          expect(parsed[:error]).to eq("Email has already been taken")
        end

        it "when an email is formatted incorrectly" do
          @user_params[:email] = "123"
          post "/api/v0/users", headers: @headers, params: @user_params.to_json
          parsed = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(400)
          expect(parsed[:error]).to eq("Email is invalid")
        end
        
        describe "when a field is missing" do
          it "nil email" do
            @user_params["email"] = nil
            post "/api/v0/users", headers: @headers, params: @user_params.to_json
            parsed = JSON.parse(response.body, symbolize_names: true)
            
            expect(response.status).to eq(400)
            expect(parsed[:error]).to eq("Email can't be blank and Email is invalid")
          end

          it "nil password" do
            @user_params["password"] = nil
            post "/api/v0/users", headers: @headers, params: @user_params.to_json
            parsed = JSON.parse(response.body, symbolize_names: true)
            
            expect(response.status).to eq(400)
            expect(parsed[:error]).to eq("Password can't be blank and Password can't be blank")
          end

          it "nil password_confirmation" do
            @user_params["password_confirmation"] = nil
            post "/api/v0/users", headers: @headers, params: @user_params.to_json
            parsed = JSON.parse(response.body, symbolize_names: true)
            
            expect(response.status).to eq(400)
            expect(parsed[:error]).to eq("Password confirmation can't be blank")
          end
        end
      end
    end
  end
end