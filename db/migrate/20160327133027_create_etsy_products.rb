class CreateEtsyProducts < ActiveRecord::Migration
  def change
    create_table :etsy_products do |t|
      t.integer :listing_id, limit: 8
      t.integer :category_id, limit: 8
      t.string :title
      t.string :description
      t.string :price
      t.string :currency_code
      t.integer :quantity
      t.json :tags
      t.json :category_path
      t.json :taxonomy_path
      t.json :materials
      t.integer :featured_rank
      t.string :url
      t.integer :views
      t.integer :num_favorers
      t.integer :shipping_template_id, limit: 8
      t.integer :shipping_profile_id, limit: 8
      t.json :images

      t.timestamps null: false
    end
  end
end
