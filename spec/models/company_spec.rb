require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { FactoryBot.build(:company) }

  describe "Params company" do
    context "company must be valid" do
      it "with valid params" do
        expect(company).to be_valid
      end

      it "with invalid params" do
        company.name = nil
        expect(company).not_to be_valid
      end
    end
  end
end
