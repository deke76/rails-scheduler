class RenameIceTimeToStartTimeInIceTimes < ActiveRecord::Migration[7.1]
  def change
    rename_column :ice_times, :ice_time, :start_time
  end
end
