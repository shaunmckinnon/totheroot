json.array!(@product_registrations) do |product_registration|
  json.extract! product_registration, :id, :first_name, :last_name, :product_name, :product_number, :phone_number, :address_line_1, :address_line_2, :postal_code, :city, :province, :country, :email, :registration_number, :date_of_manufacture
  json.url product_registration_url(product_registration, format: :json)
end
