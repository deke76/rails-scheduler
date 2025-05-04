class AddAddressToIceTimes < ActiveRecord::Migration[7.1]
  def change
    add_reference :ice_times, :address, null: false, foreign_key: true, type: :uuid
  end
end
