class AddDeletedAtToProductRegistration < ActiveRecord::Migration
  def change
    add_column :product_registrations, :deleted_at, :datetime
    add_index :product_registrations, :deleted_at
  end
end
