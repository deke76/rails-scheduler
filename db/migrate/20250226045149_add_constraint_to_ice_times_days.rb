class AddConstraintToIceTimesDays < ActiveRecord::Migration[7.1]
  def change

    add_check_constraint :ice_times, "day IN ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')"
  end
end
