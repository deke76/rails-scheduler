class IceTime < ApplicationRecord
  belongs_to :team
  belongs_to :address
  belongs_to :opponent, class_name: 'Team', optional: true
  before_save :set_start_time
  
  attr_accessor :hour, :minute, :am_pm
  VALID_DAYS = %w[sunday monday tuesday wednesday thursday friday saturday].freeze

  validates :day, inclusion: { in: VALID_DAYS }
  validates :hour, presence: true, numericality: { in: 1..12 }
  validates :minute, presence: true, numericality: { in: 0..59 }
  validates :am_pm, presence: true, inclusion: { in: %w[AM PM] }
  validates :length, presence: true, numericality: { greater_than: 0 }
  validates :team_id, presence: true

  def day_display
    day == 'thursday' ? 'R' : day.first.upcase
  end

  def set_start_time
    self.start_time = convert_to_psql_time(hour, minute, am_pm)
  end

  def convert_to_psql_time(hour, minute, am_pm)
    hour = hour.to_i
    minute = minute.to_i
    am_pm = am_pm.downcase

    if am_pm == 'pm' && hour < 12
      hour += 12
    end
    Time.new(2025, 1, 1, hour, minute, 0, '+00:00')
  end
end
