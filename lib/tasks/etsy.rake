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

  desc "Get all listings (runs every few minutes)"
  task :get_all_listings => :environment do
    Etsy.protocol = 'https'
    Etsy.api_key = Rails.application.secrets.etsy_api_key
    Etsy.api_secret = Rails.application.secrets.etsy_api_secret

    user = Etsy.user 'ToTheRoot'
    shop = user.shop.result
    shop_sections = user.shop.sections

    limit = 100
    inventory_count = shop["listing_active_count"]

    # get all the shop sections from Etsy
    sections = shop_sections.map{ |section| section.result }

    # compare and remove sections that no longer exist
    shop_section_ids = sections.map{ |section| section["shop_section_id"] }
    del_shop_sections = EtsyShopSection.where.not(shop_section_id: shop_section_ids)
    EtsyShopSection.transaction do
      puts "Removing shop sections."
      del_shop_sections.each do |section|
        section.destroy
      end
    end

    # add the sections or update them
    EtsyShopSection.transaction do
      puts "Adding/updating shop sections."
      sections.each do |section|
        shop_section = EtsyShopSection.find_or_initialize_by(shop_section_id: section["shop_section_id"])
        shop_section.title = section["title"]
        shop_section.rank = section["rank"]
        shop_section.save!
      end
    end

    # get all the listings from Etsy
    listings = []
    (0...((inventory_count.to_f / limit).ceil)).each do |os|
      listing_group = Etsy::Listing.find_all_by_shop_id( user.shop.id, limit: limit, offset: (os * limit) )
      listing_group.each{ |listing| listings << listing }
    end

    # compare and remove any old listings or nil listings
    etsy_listing_ids = listings.map{ |l| l.result["listing_id"] }
    sold_listings = EtsyProduct.where.not(listing_id: etsy_listing_ids)
    EtsyProduct.transaction do
      puts "Removing old listings."
      sold_listings.each do |listing|
        listing.destroy
      end
    end

    # Add and update all listings
    EtsyProduct.transaction do
      puts "Adding/updating new listings."
      listings.each do |listing|
        unless listing.result["when_made"] == "made_to_order"
          product = EtsyProduct.find_or_initialize_by(listing_id: listing.result["listing_id"])
          product.category_id = listing.result["listing_id"]
          product.shop_section_id = listing.result["shop_section_id"]
          product.title = listing.result["title"]
          product.description = listing.result["description"]
          product.price = listing.result["price"]
          product.currency_code = listing.result["currency_code"]
          product.quantity = listing.result["quantity"]
          product.tags = listing.result["tags"]
          product.category_path = listing.result["category_path"]
          product.taxonomy_path = listing.result["taxonomy_path"]
          product.materials = listing.result["materials"]
          product.featured_rank = listing.result["featured_rank"]
          product.url = listing.result["url"]
          product.views = listing.result["views"]
          product.num_favorers = listing.result["num_favorers"]
          product.shipping_template_id = listing.result["shipping_template_id"]
          product.shipping_profile_id = listing.result["shipping_profile_id"]
          product.images = listing.images.map{ |image| image.result["url_fullxfull"] }
          product.registration_code = EtsyProduct.generate_registration_code if product.registration_code.blank?
          product.save!
        end
      end
    end

    # UserMailer.cron_task_complete.deliver_now
  end

end