require 'rails_helper'

RSpec.describe "Api::V1::Schedules", type: :request do
  let(:contract) { FactoryBot.build(:contract) }
  let(:user) { FactoryBot.build(:user)}
  let(:token) { "Bearer #{JsonWebToken.encode({ id: user.id }, DateTime.now.advance(days: 7))}" }

  before do
    @authorization = {'Authorization': token}
  end

  describe "schedule endpoints" do
    context "returns schedule" do

      it "returns http ok" do
        get "/api/v1/schedules", headers: @authorization, as: :json

        parsed = JSON.parse(response.body)

        expect(parsed).to include('data')
        expect(response).to have_http_status(:ok)
      end

      it "returns http forbidden" do
        get "/api/v1/schedules", as: :json
        
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "create schedules" do
      it "returns http created" do
        params = { schedule: FactoryBot.attributes_for(:schedule, contract_id: contract.id) }
          
        post '/api/v1/schedules', params: params, headers: @authorization, as: :json
        
        expect(response).to have_http_status(:created)
      end

      it "returns http unprocessable_entity" do
        params = { schedule: FactoryBot.attributes_for(:company, duration: nil) }

        post '/api/v1/schedules', params: params, headers: @authorization, as: :json
        parsed = JSON.parse(response.body)

        expect(parsed).to include('duration' => ["can't be blank"])
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "update schedules" do
      it "returns http ok" do
        params = { schedule: FactoryBot.attributes_for(:schedule) }
          
        patch "/api/v1/schedules/#{1}", params: params, headers: @authorization, as: :json
        
        expect(response).to have_http_status(:ok)
      end

      it "returns http unprocessable_entity" do
        params = { schedule: FactoryBot.attributes_for(:schedule, duration: nil) }

        patch '/api/v1/companies', params: params, headers: @authorization, as: :json
        parsed = JSON.parse(response.body)

        expect(parsed).to include('error' => "Not Found")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
