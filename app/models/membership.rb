class Membership < ApplicationRecord
  belongs_to :user
  
  enum role: { owner: 0, admin: 1, player: 2 }

  # validates :user_id, uniqueness: { scope: [:team_id, :role], message: "is already assigned to this role in the team" }

  scope :admins, -> { where(role: :admin) }
  scope :players, -> { where(role: :player) }
end

