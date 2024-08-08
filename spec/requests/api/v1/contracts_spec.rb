require 'rails_helper'

RSpec.describe "/contracts", type: :request do
  let(:company) { FactoryBot.build(:company) }
  let(:user) { FactoryBot.build(:user)}
  let(:token) { "Bearer #{JsonWebToken.encode({ id: user.id }, DateTime.now.advance(days: 7))}" }

  before do
    @authorization = {'Authorization': token}
  end

  describe "Contracts endpoints" do
    context "returns contracts" do

      it "returns http ok" do
        get "/api/v1/contracts", headers: @authorization, as: :json

        parsed = JSON.parse(response.body)

        expect(parsed).to include('data')
        expect(response).to have_http_status(:ok)
      end

      it "returns http forbidden" do
        get "/api/v1/contracts", as: :json
        
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "create contract" do
      it "returns http created" do
        params = { contract: FactoryBot.attributes_for(:contract) }
          
        post '/api/v1/contracts', params: params, headers: @authorization, as: :json

        expect(response).to have_http_status(:created)
      end

      it "returns http unprocessable_entity" do
        params = { contract: FactoryBot.attributes_for(:contract, start_date: nil) }

        post '/api/v1/contracts', params: params, headers: @authorization, as: :json
        parsed = JSON.parse(response.body)

        expect(parsed).to include('start_date' => ["can't be blank"])
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "update contract" do
      it "returns http ok" do
        params = { contract: FactoryBot.attributes_for(:contract) }
          
        patch "/api/v1/contracts/#{1}", params: params, headers: @authorization, as: :json
        parsed = JSON.parse(response.body)

        expect(parsed).to include('id')
        expect(response).to have_http_status(:ok)
      end

      it "returns http unprocessable_entity" do
        params = { contract: FactoryBot.attributes_for(:contract, name: nil) }

        patch '/api/v1/contracts', params: params, headers: @authorization, as: :json
        parsed = JSON.parse(response.body)

        expect(parsed).to include('error' => "Not Found")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
