class Team < ApplicationRecord
  validates_presence_of :name
  has_one_attached :logo, dependent: :destroy
  has_many :memberships, dependent: :destroy

  def small_logo
    logo.variant(resize_to_limit: [100, 100]).processed
  end
end
