class Company < ApplicationRecord
  has_many :contracts
  has_many :shifts
  has_many :supports
  has_many :users, :through => :supports

  validates :name, presence: true

end
