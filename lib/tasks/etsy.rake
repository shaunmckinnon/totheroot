require 'etsy'

namespace :etsy do

  namespace :auth do

    desc "Get a new access token"
    task :get_new_token => :environment do
      Etsy.protocol = 'https'
      Etsy.api_key = Rails.application.secrets.etsy_api_key
      Etsy.api_secret = Rails.application.secrets.etsy_api_secret
      request = Etsy.request_token

      # provide URL and follow verification (this desperately needs to be cleaned up and made nicer. This is a terrible bandaid and you should be ashamed of yourself.)
      STDOUT.puts Etsy.verification_url
      STDOUT.puts "Enter the code: "
      code = STDIN.gets.strip

      # store access.token and access.secret, plus api_key and api_secret
      access = Etsy.access_token(request.token, request.secret, code)
      ed = EtsyDeet.new
      ed.access_token = access.token
      ed.access_secret = access.secret
      ed.save
    end

  end

  desc "Get all listings (runs every few minutes and nukes and paves table with an updated list)"
  task :get_all_listings => :environment do
    Etsy.protocol = 'https'
    Etsy.api_key = Rails.application.secrets.etsy_api_key
    Etsy.api_secret = Rails.application.secrets.etsy_api_secret

    user = Etsy.user 'ToTheRoot'
    shop = user.shop.result
    limit = 5
    inventory_count = shop["listing_active_count"]

    listings = []
    (0...((inventory_count.to_f / 100).ceil)).each do |os|
      listings << Etsy::Listing.find_all_by_shop_id( user.shop.id, limit: limit, offset: (os * 100) )
    end

    esp = ExtShopProduct.first
    esp.update(product: listings)
    esp.save
  end

  desc "Get changed listings"
  task :get_updated_listings => :environment do
    Etsy.protocol = 'https'
    Etsy.api_key = Rails.application.secrets.etsy_api_key
    Etsy.api_secret = Rails.application.secrets.etsy_api_secret
    token = EtsyDeet.first.access_token
    secret = EtsyDeet.first.access_secret
    
    if token && secret
      user = Etsy.myself(token, secret)
      shop = user.shop
      access = { :access_token => token, :access_secret => secret }
      listings = Etsy::Listing.find_all_by_shop_id(user.shop.id, access.merge(:fields => ['listing_id', 'last_modified_tsz'], :limit => 100))      
    end
  end

end