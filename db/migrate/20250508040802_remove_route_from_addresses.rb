class RemoveRouteFromAddresses < ActiveRecord::Migration[7.1]
  def change
    remove_column :addresses, :route, :string
  end
end
