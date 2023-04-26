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

    @user = User.create(
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

    context "when unsuccessful" do
      describe "it returns a 401 status code" do
        it "when the email params don't match an existing user" do
          @user_params[:email] = "hello@hello.com"
          post "/api/v0/sessions", headers: @headers, params: @user_params.to_json
          parsed = JSON.parse(response.body, symbolize_names: true)
  
          expect(response.status).to eq(401)
          expect(parsed[:error]).to eq("Credentials are Invalid")
        end

        it "when the password is wrong for the existing user's email" do
          @user_params[:password] = "123"
          post "/api/v0/sessions", headers: @headers, params: @user_params.to_json
          parsed = JSON.parse(response.body, symbolize_names: true)
  
          expect(response.status).to eq(401)
          expect(parsed[:error]).to eq("Credentials are Invalid")
        end

        it "when an email is formatted incorrectly" do
          @user_params["email"] = "123"
          post "/api/v0/sessions", headers: @headers, params: @user_params.to_json
          parsed = JSON.parse(response.body, symbolize_names: true)
          
          expect(response.status).to eq(401)
          expect(parsed[:error]).to eq("Credentials are Invalid")
        end
      end

      describe "it returns a 400 status code" do
        describe "when a field is missing" do
          it "nil email" do
            @user_params["email"] = nil
            post "/api/v0/sessions", headers: @headers, params: @user_params.to_json
            parsed = JSON.parse(response.body, symbolize_names: true)
            
            expect(response.status).to eq(400)
            expect(parsed[:error]).to eq("One or more Credentials are missing")
          end

          it "nil password" do
            @user_params["password"] = nil
            post "/api/v0/sessions", headers: @headers, params: @user_params.to_json
            parsed = JSON.parse(response.body, symbolize_names: true)
            
            expect(response.status).to eq(400)
            expect(parsed[:error]).to eq("One or more Credentials are missing")
          end
        end
      end
    end
  end
end
