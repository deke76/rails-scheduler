class AddMembershipReferenceToTeams < ActiveRecord::Migration[7.1]
  def change
    add_reference :teams, :membership, null: false, foreign_key: true, type: :uuid
  end
end
