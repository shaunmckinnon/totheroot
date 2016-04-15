class AddDeletedAtToEtsyProduct < ActiveRecord::Migration
  def change
    add_column :etsy_products, :deleted_at, :datetime
    add_index :etsy_products, :deleted_at
  end
end
