require 'rails_helper'

RSpec.describe "Api::V1::Companies", type: :request do
  let(:company) { FactoryBot.build(:company) }
  let(:user) { FactoryBot.build(:user)}
  let(:token) { "Bearer #{JsonWebToken.encode({ id: user.id }, DateTime.now.advance(days: 7))}" }

  before do
    @authorization = {'Authorization': token}
  end

  describe "Companies endpoints" do
    context "returns companies" do

      it "returns http ok" do
        get "/api/v1/companies", headers: @authorization, as: :json

        parsed = JSON.parse(response.body)

        expect(parsed).to include('data')
        expect(response).to have_http_status(:ok)
      end

      it "returns http forbidden" do
        get "/api/v1/companies", as: :json
        
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "create company" do
      it "returns http created" do
        params = { company: FactoryBot.attributes_for(:company) }
          
        post '/api/v1/companies', params: params, headers: @authorization, as: :json
        parsed = JSON.parse(response.body)

        expect(parsed).to include('id')
        expect(response).to have_http_status(:created)
      end

      it "returns http unprocessable_entity" do
        params = { company: FactoryBot.attributes_for(:company, name: nil) }

        post '/api/v1/companies', params: params, headers: @authorization, as: :json
        parsed = JSON.parse(response.body)

        expect(parsed).to include('name' => ["can't be blank"])
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "update company" do
      it "returns http ok" do
        params = { company: FactoryBot.attributes_for(:company) }
          
        patch "/api/v1/companies/#{1}", params: params, headers: @authorization, as: :json
        parsed = JSON.parse(response.body)

        expect(parsed).to include('id')
        expect(response).to have_http_status(:ok)
      end

      it "returns http unprocessable_entity" do
        params = { company: FactoryBot.attributes_for(:company, name: nil) }

        patch '/api/v1/companies', params: params, headers: @authorization, as: :json
        parsed = JSON.parse(response.body)

        expect(parsed).to include('error' => "Not Found")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
