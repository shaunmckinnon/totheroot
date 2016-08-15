class CreateEtsyShopSections < ActiveRecord::Migration
  def change
    create_table :etsy_shop_sections do |t|
      t.integer :shop_section_id, limit: 8
      t.string :title
      t.integer :rank, limit: 8

      t.timestamps null: false
    end
  end
end
