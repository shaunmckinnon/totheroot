class AddSlugToEtsyShopSections < ActiveRecord::Migration
  def change
    add_column :etsy_shop_sections, :slug, :string
  end
end
