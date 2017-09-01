class ShopSection < ActiveRecord::Base
  belongs_to :etsy_shop_section, class_name: 'EtsyShopSection'
end
