require 'rails_helper'

RSpec.describe Schedule, type: :model do
  let(:schedule) { FactoryBot.build(:schedule)}
  
  describe "Params schedule" do
    context "schedule must be valid" do
      it "with valid params" do
        expect(schedule).to be_valid
      end

      it "with start_hour nil" do
        schedule.start_hour = nil

        expect(schedule).not_to be_valid
      end

      it "with end_hour nil" do
        schedule.end_hour = nil

        expect(schedule).not_to be_valid
      end

      it "with duration nil" do
        schedule.duration = nil

        expect(schedule).not_to be_valid
      end

      it "with invalid contract" do
        schedule.contract = nil

        expect(schedule).not_to be_valid
      end
    end
  end
end
