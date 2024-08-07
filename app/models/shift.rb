class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  belongs_to :company

  validates :start_hour, presence: true
  validates :end_hour, presence: true

  DAYS = {
    1 => 'lunes',
    2 => 'martes',
    3 => 'miércoles',
    4 => 'jueves',
    5 => 'viernes',
    6 => 'sábado',
    7 => 'domingo'
  }.freeze

  def day_format
    position = start_hour.strftime('%u').to_i
    "#{DAYS[position].capitalize} #{start_hour.day} #{start_hour.strftime('%b')}"
  end
end
