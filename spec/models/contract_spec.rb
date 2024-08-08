require 'rails_helper'

RSpec.describe Contract, type: :model do
  let(:contract) { FactoryBot.build(:contract) }

  describe "Params contract" do
    context "contract must be valid" do
      it "with valid params" do
        expect(contract).to be_valid
      end

      it "with invalid dates" do
        contract.start_date = nil
        contract.end_date = nil

        expect(contract).not_to be_valid
      end

      it "with start_date nil" do
        contract.start_date = nil

        expect(contract).not_to be_valid
      end

      it "with end_date nil" do
        contract.end_date = nil

        expect(contract).not_to be_valid
      end

      it "with invalid company" do
        contract.company = nil

        expect(contract).not_to be_valid
      end
    end
  end
end
