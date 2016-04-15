class CreateProductRegistrations < ActiveRecord::Migration
  def change
    create_table :product_registrations do |t|
      t.string :first_name
      t.string :last_name
      t.string :product_name
      t.string :product_number
      t.string :phone_number
      t.string :address_line_1
      t.string :address_line_2
      t.string :postal_code
      t.string :city
      t.string :province
      t.string :country
      t.string :email
      t.string :registration_number
      t.datetime :date_of_manufacture

      t.timestamps null: false
    end
  end
end
