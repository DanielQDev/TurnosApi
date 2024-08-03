require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:user) { FactoryBot.build(:user) }

  describe "GET /show" do
    context "returns user" do
      it "returns http ok" do
        id = 1
        get "/api/v1/users/#{id}"

        parsed = JSON.parse(response.body)

        expect(parsed).to include('id' => id)
        expect(response).to have_http_status(:ok)
      end

      it "returns http not_found" do
        id = 1
        get "/api/v1/users/#{id}"

        parsed = JSON.parse(response.body)

        expect(parsed).to include('error')
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PUT/PATCH /update" do
    context "update user data" do
      it "returns http ok" do
        id = user.id
        params = {user: FactoryBot.attributes_for(:user)}

        patch "/api/v1/users/#{id}", params: params, as: :json
        parsed = JSON.parse(response.body)

        expect(parsed).to include('id' => id)
        expect(response).to have_http_status(:ok)
      end

      it "returns http not_found" do
        id = nil
        params = {user: FactoryBot.attributes_for(:user)}

        patch "/api/v1/users/#{id}", params: params, as: :json
        expect(response).to have_http_status(:not_found)
      end

      it "returns http unprocessable_entity" do
        id = user.id
        params = {user: FactoryBot.attributes_for(:user, email: nil)}

        patch "/api/v1/users/#{id}", params: params, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
