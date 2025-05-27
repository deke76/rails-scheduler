json.extract! address, :id, :name, :unit_number, :street_number, :street, :city, :province, :country, :postal_code, :latitude, :longitude, :created_at, :updated_at
json.url address_url(address, format: :json)
