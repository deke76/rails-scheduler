class Team < ApplicationRecord
  validates_presence_of :name

  # has_many :memberships
  # has_many :users, through: :memberships, source: :user
end
