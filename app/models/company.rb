class Company < ApplicationRecord
  has_many :contracts
  has_many :shifts

  validates :name, presence: true
end
