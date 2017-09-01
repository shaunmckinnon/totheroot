class EtsyShopSection < ActiveRecord::Base

  has_many :etsy_products, class_name: 'EtsyProduct', foreign_key: 'shop_section_id', primary_key: 'shop_section_id'

  has_many :shop_sections

end
