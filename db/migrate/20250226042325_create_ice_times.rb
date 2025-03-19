class CreateIceTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :ice_times, id: :uuid do |t|
      t.string :day
      t.time :ice_time
      t.integer :length
      t.references :team, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
