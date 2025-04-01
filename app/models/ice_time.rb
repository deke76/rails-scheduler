class IceTime < ApplicationRecord
  belongs_to :team

  VALID_DAYS = %w[monday tuesday wednesday thursday friday saturday sunday].freeze

  validates :day, inclusion: { in: VALID_DAYS }
  validates :ice_time, presence: true
  validates :length, presence: true, numericality: { greater_than: 0 }
  validates :team_id, presence: true

  def day_display
    day == 'thursday' ? 'R' : day.first.upcase
  end
end
