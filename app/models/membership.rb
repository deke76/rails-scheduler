class Membership < ApplicationRecord
  # belongs_to :user
  # belongs_to :account
  
  # enum role: { owner: 0, admin: 1, member: 2 }

  # validates :user_id, uniqueness: { scope: :account_id, message: "is already a member of this account" }

  # scope :admins, -> { where(role: :admin) }
  # scope :players, -> { where(role: :player) }
end

