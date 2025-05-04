class IceTime < ApplicationRecord
  belongs_to :team
  belongs_to :address
  before_save :set_start_time
  
  attr_accessor :hour, :minute, :am_pm
  VALID_DAYS = %w[sunday monday tuesday wednesday thursday friday saturday].freeze

  validates :day, inclusion: { in: VALID_DAYS }
  validates :ice_time, presence: true
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
