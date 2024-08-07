class Schedule < ApplicationRecord
  belongs_to :contract
  has_many :shifts
  
  validates :start_hour, presence: true
  validates :end_hour, presence: true
  validates :duration, presence: true
end
