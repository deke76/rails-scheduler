class RenameCountryNameToCountry < ActiveRecord::Migration[7.1]
  def change
    rename_column :addresses, :country_name, :country
  end
end
