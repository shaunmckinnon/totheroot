class CreateExtShops < ActiveRecord::Migration
  def change
    create_table :ext_shops do |t|
      t.string :name
      t.string :url

      t.timestamps null: false
    end
  end
end
