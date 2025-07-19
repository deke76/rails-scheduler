class Team < ApplicationRecord
  validates_presence_of :name
  has_one_attached :logo, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :ice_times, dependent: :destroy
  has_many :opponent_ice_times, class_name: 'IceTime', foreign_key: 'opponent_id', dependent: :nullify

  def small_logo
    logo.variant(resize_to_limit: [100, 100]).processed
  end
end
