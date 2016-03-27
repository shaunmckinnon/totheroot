class CreateExtShopProducts < ActiveRecord::Migration
  def change
    create_table :ext_shop_products do |t|
      t.references :ext_shop, index: true, foreign_key: true
      t.json :product

      t.timestamps null: false
    end
  end
end
