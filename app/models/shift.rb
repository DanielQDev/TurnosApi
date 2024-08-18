class Shift < ApplicationRecord
  has_many :applications
  has_many :users, :through => :applications

  belongs_to :schedule
  belongs_to :company

  validates :start_hour, presence: true
  validates :end_hour, presence: true

  scope :shifts_by_week, -> (week, company_id) { where(week: week, company_id: company_id)}
  scope :weeks, -> { where(start_hour: ..Time.now.advance(weeks: 5))}

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

  def week_format
    "Semana #{week} #{start_hour.year}"
  end

  def self.for_user(week, company)
    find_by_sql(
      "SELECT
        DATE(start_hour) AS day,
        array_agg(
          json_build_object(
            'id', id,
            'start_hour', start_hour,
            'end_hour', end_hour,
            'week', week
          )
        ) AS shifts FROM shifts
        WHERE week = '#{week}' AND company_id = #{company}
        GROUP BY day
        ORDER BY day"
    )
  end

  def self.by_confirmed_user(week, company)
    find_by_sql(
      "SELECT
        DATE(start_hour) AS day,
        array_agg(
          json_build_object(
            'id', shifts.id,
            'start_hour', start_hour,
            'end_hour', end_hour,
            'user_name', first_name,
            'color', color
          )
        ) AS shifts FROM shifts
        INNER JOIN applications ON shifts.id = applications.shift_id 
        INNER JOIN users ON applications.user_id = users.id
        WHERE week = '#{week}' AND company_id = #{company}
        GROUP BY day
        ORDER BY day"
    )
  end
end
