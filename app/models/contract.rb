class Contract < ApplicationRecord
  belongs_to :company
  has_many :schedules

  validates :start_date, presence: true
  validates :end_date, presence: true
end
