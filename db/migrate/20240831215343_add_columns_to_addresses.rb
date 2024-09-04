class AddColumnsToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :name, :string
    add_column :addresses, :unit_number, :string
    add_column :addresses, :street_number, :string
    add_column :addresses, :street, :string
    add_column :addresses, :city, :string
    add_column :addresses, :country_name, :string
    add_column :addresses, :province, :string
    add_column :addresses, :postal_code, :string
  end
end
