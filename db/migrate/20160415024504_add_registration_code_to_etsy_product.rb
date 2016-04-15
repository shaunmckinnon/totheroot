class AddRegistrationCodeToEtsyProduct < ActiveRecord::Migration
  def change
    add_column :etsy_products, :registration_code, :string
  end
end
