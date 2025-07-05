class AddOpponentToIceTimes < ActiveRecord::Migration[7.1]
  def change
    add_reference :ice_times, :opponent, null: true, foreign_key: { to_table: :teams }, type: :uuid
  end
end
