require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }
  

  context "User mush be valid." do
    it "with valid params" do
      expect(user).to be_valid
    end

    it "return full name user" do
      expect(user.full_name).to eq "#{user.first_name} #{user.last_name}"
    end
  end

  context "User mush not be valid." do
    it "with email null" do
      user.email = nil

      expect(user).not_to be_valid
    end

    it "with invalid email" do
      user.email = 'my_email'

      expect(user).not_to be_valid
    end

    it "with password null" do
      user.password = nil

      expect(user).not_to be_valid
    end
  end
end
