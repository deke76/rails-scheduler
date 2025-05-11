class AddRouteToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :route, :string
  end
end
