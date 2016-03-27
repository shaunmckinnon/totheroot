# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ExtShop.create([
  {
    name: 'Etsy',
    url: 'https://www.etsy.com/shop/ToTheRoot'
  }
])

ExtShop.create([
  ext_shop_id: 1,
  product: nil
])