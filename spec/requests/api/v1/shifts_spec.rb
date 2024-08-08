require 'rails_helper'

RSpec.describe "/shifts", type: :request do
  let(:user) { FactoryBot.build(:user)}
  let(:token) { "Bearer #{JsonWebToken.encode({ id: user.id }, DateTime.now.advance(days: 7))}" }

  before do
    @authorization = {'Authorization': token}
  end

  describe "shift endpoints" do
    context "returns shifts" do

      it "returns http ok" do
        params = {company: 1, week: 1}
        get "/api/v1/shifts", headers: @authorization, params: params, as: :json

        parsed = JSON.parse(response.body)

        expect(parsed).to include('data')
        expect(response).to have_http_status(:ok)
      end

      it "returns http forbidden" do
        get "/api/v1/shifts", as: :json
        
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "create shifts" do
      it "returns http created" do
        params = { shift: FactoryBot.attributes_for(:shift, user_id: 1, schedule_id: 1, company_id: 1) }
          
        post '/api/v1/shifts', params: params, headers: @authorization, as: :json
        
        expect(response).to have_http_status(:created)
      end

      it "returns http unprocessable_entity" do
        params = { shift: FactoryBot.attributes_for(:shift) }

        post '/api/v1/shifts', params: params, headers: @authorization, as: :json
        parsed = JSON.parse(response.body)

        expect(parsed).to include("user" => ["must exist"])
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "update shifts" do
      it "returns http ok" do
        params = { schedule: FactoryBot.attributes_for(:schedule) }
          
        patch "/api/v1/shifts/#{1}", params: params, headers: @authorization, as: :json
        
        expect(response).to have_http_status(:ok)
      end

      it "returns http unprocessable_entity" do
        params = { schedule: FactoryBot.attributes_for(:schedule, user_id: nil) }

        patch "/api/v1/shifts/#{0}", params: params, headers: @authorization, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "returns confirmed shifts" do

      it "returns http ok" do
        params = {company: 1, week: 1}
        get "/api/v1/confirmed", headers: @authorization, params: params, as: :json

        parsed = JSON.parse(response.body)

        expect(parsed).to include('data')
        expect(response).to have_http_status(:ok)
      end

      it "returns http forbidden" do
        get "/api/v1/confirmed", as: :json
        
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
