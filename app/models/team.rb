class Team < ApplicationRecord
  validates_presence_of :name
  has_one_attached :logo
  has_many :memberships, dependent: :destroy
end
