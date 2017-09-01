class AddColumnToShopSection < ActiveRecord::Migration
  def change
    add_reference :shop_sections, :etsy_shop_section, index: true, foreign_key: true
  end
end
