require 'rails_helper'

RSpec.describe "Api::V1::Auths", type: :request do
  let(:user) { FactoryBot.build(:user) }

  describe "POST /signin" do
    it "returns http success" do
      params = {
        user: {
          "email": user.email,
          "password": user.password
        }
      }

      post "/api/v1/signin", params: params, as: :json

      expect(JSON.parse(response.body)['authorization']).not_to be_nil
      expect(response).to have_http_status(:success)
    end

    it "invalid email, returns http not_found" do
      params = {
        user: {
          "email": "invalid@mail.com",
          "password": user.password
        }
      }
      post "/api/v1/signin", params: params, as: :json
      expect(response).to have_http_status(:not_found)
    end

    it "invalid password, returns http not_found" do
      params = {
        user: {
          "email": user.email,
          "password": nil
        }
      }
      post "/api/v1/signin", params: params, as: :json
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /signup" do
    it "returns http success" do
      params = {
        user: {
          'email': 'test@email.com',
          'first_name': 'jonh',
          'last_name': 'doe',
          'password': '12345abc',
          'role': 'admin',
          'color': '#f1f1f1'
        }
      }

      post "/api/v1/signup", params: params, as: :json
      parsed = JSON.parse(response.body)

      expect(parsed).to include('authorization')
      expect(response).to have_http_status(:success)
    end

    it "invalid data, returns http unprocessable_entity" do
      params = {
        user: {
          'email': nil,
          'first_name': 'jonh',
          'last_name': 'doe',
          'role': 'admin',
          'color': '#f1f1f1'
        }
      }

      post "/api/v1/signup", params: params, as: :json

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # describe "GET /refresh" do
  #   it "returns http success" do
  #     get "/api/v1/auth/refresh"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
