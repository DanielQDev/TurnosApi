require 'rails_helper'

RSpec.describe Shift, type: :model do
  let(:shift) { FactoryBot.build(:shift) }
  let(:user) { FactoryBot.build(:user) }

  describe "Shift params" do
    context "shift must be valid" do
      it "with valid params" do
        expect(shift).to be_valid
      end

      it "with start_hour nil" do
        shift.start_hour = nil

        expect(shift).not_to be_valid
      end

      it "with end_hour nil" do
        shift.end_hour = nil

        expect(shift).not_to be_valid
      end

      it "with invalid user" do
        shift.user = nil

        expect(shift).not_to be_valid
      end

      it "with invalid company" do
        shift.company = nil

        expect(shift).not_to be_valid
      end

      it "with invalid schedule" do
        shift.schedule = nil

        expect(shift).not_to be_valid
      end
    end
  end

  describe "methods and scopes" do
    context "returns valid data" do
      it "returns correct format day" do
        expect(shift.day_format).to eql 'Martes 6 Aug'
      end

      pending "returns only confirmed" do
        FactoryBot.create_list(:shift, 10, is_confirmed: true, user: user)

        shifts_found = described_class.confirmed
        confirmed = shifts_found.pluck(:is_confirmed).uniq

        expect(confirmed.first).to be true
      end

      pending "returns only postulated" do
        FactoryBot.create_list(:shift, 10, is_postulated: true, user: user)

        shifts_found = described_class.postulate
        postulate = shifts_found.pluck(:is_postulated).uniq

        expect(postulate.first).to be true
      end
    end
  end
end
