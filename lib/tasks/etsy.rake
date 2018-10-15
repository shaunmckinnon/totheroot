# This is the Etsy collector task
# This task will collect all shop
# sections and listings from the
# Etsy API. These are public
# methods.

# dependencies
require 'http'

namespace :etsy do
  SHOP_REQ_URI = "shops/#{ENV['etsy_shop_id']}"
  @request_count = 0

  def etsy_request(request_string, additional_params = "")
    sleep 1
    api_key = ENV['etsy_api_key']
    etsy_request_url = "https://openapi.etsy.com/v2"
    etsy_api_key_string = "?api_key=#{api_key}"
    request_uri = "#{etsy_request_url}/#{request_string}#{etsy_api_key_string}#{additional_params}"
    puts "Getting Request: #{request_uri}"
    @request_count += 1
    puts "...current request count: #{@request_count}...\n\n"
    results = JSON.parse HTTP.get(request_uri).to_s
    sleep 1
    return results
  end

  def etsy_get_shop
    shop_req_uri = "users/#{ENV['etsy_user_id']}/shops"
    return etsy_request(shop_req_uri)
  end

  def get_active_listings_count
    shop = etsy_get_shop()
    return shop["results"][0]["listing_active_count"]
  end

  def etsy_get_shop_sections
    shop_sections_uri = "#{SHOP_REQ_URI}/sections"
    shop_sections = etsy_request(shop_sections_uri)
    return shop_sections["results"].map{ |section| section }
  end

  def etsy_get_active_listings
    # get number of active listings
    listing_count = get_active_listings_count()
    puts "Total listing count is #{listing_count}."

    listings_uri = "#{SHOP_REQ_URI}/listings/active"

    # limit number of returned products
    limit = 100

    # establish how many calls you'll need
    total_calls = (listing_count.to_f / limit).ceil
    puts "We have to make #{total_calls} to get all the listings."

    # listings
    listings = []
    (0...total_calls).each do |call|
      puts "Current Call: #{call}:"
      listing_group = etsy_request(listings_uri, "&limit=#{limit}&offset=#{call * limit}")
      listing_group["results"].each{ |listing| listings << listing }
    end

    puts "We retrieved #{listings.count} total listings."
    puts "We are done retrieving listings"
    return listings
  end

  def etsy_get_listing_images(listing_id)
    listing_images_uri = "listings/#{listing_id}/images"
    listing_images = etsy_request(listing_images_uri)
    listing_images["results"].map{ |images| {
      rank: images["rank"],
      url_75x75: images["url_75x75"],
      url_170x135: images["url_170x135"],
      url_570xN: images["url_570xN"],
      url_fullxfull: images["url_fullxfull"]
    } }
  end

  # compare DB to ids
  def get_shop_section_diff_ids(ids)
    shop_section_db_ids = EtsyShopSection.where.not(shop_section_id: ids).pluck(:shop_section_id)
  end

  def get_listing_diff_ids(ids)
    listing_db_ids = EtsyProduct.where.not(listing_id: ids).pluck(:listing_id)
  end


  # Our task
  desc "Get all listings (runs every few minutes)"
  task :get_all_listings => :environment do
    # get all the shop sections
    puts "\nGetting Shop Sections:"
    shop_sections = etsy_get_shop_sections()

    # get all the listings
    puts "\nGetting Active Listings"
    listings = etsy_get_active_listings()

    # get all the shop section ids
    puts "\nIsolating shop section ids."
    shop_section_ids = shop_sections.map{ |section| section["shop_section_id"] }

    # get all the listing ids
    puts "\nIsolating Listing Ids"
    listing_ids = listings.map{ |listing| listing["listing_id"] }

    # get the diff ids from the db compare
    shop_section_diff_ids = get_shop_section_diff_ids(shop_section_ids)
    listing_diff_ids = get_listing_diff_ids(listing_ids)
    puts "\nThere are #{shop_section_diff_ids.count} shop sections that need to be removed."
    puts "There are #{listing_diff_ids.count} listings that need to be removed"

    # remove shop sections if different
    if shop_section_diff_ids.count > 0
      # get the records to be destroyed
      shop_sections_to_be_del = EtsyShopSection.where(shop_section_id: shop_section_diff_ids)
      EtsyShopSection.transaction do
        puts "Removing shop Sections."
        shop_sections_to_be_del.each do |section|
          section.destroy
        end
      end
    end

    # Add/Update Shop Sections
    EtsyShopSection.transaction do
      puts "Adding/Updating shop sections."
      shop_sections.each do |section|
        shop_section = EtsyShopSection.find_or_initialize_by(shop_section_id: section["shop_section_id"])
        shop_section.title = section["title"]
        shop_section.slug = section['title'].parameterize.dasherize
        shop_section.rank = section["rank"]
        shop_section.save!
      end      
    end

    # remove listings if different
    if listing_diff_ids.count > 0
      # get the records to be destroyed
      listings_to_be_del = EtsyProduct.where(listing_id: listing_diff_ids)
      EtsyProduct.transaction do
        puts "Removing shop Sections."
        listings_to_be_del.each do |listing|
          listing.destroy
        end
      end
    end

    # establish new listings list
    cur_db_ids = EtsyProduct.pluck(:listing_id)
    puts "Current DB IDs count: #{cur_db_ids.count}"
    puts cur_db_ids.inspect
    puts listing_ids.inspect
    new_ids = listing_ids - cur_db_ids
    puts "New IDs count: #{new_ids.count}"
    new_listings = listings.select{ |listing| new_ids.include?(listing["listing_id"]) }
    puts "Total New Listings: #{new_listings.count}"
    puts "New Listings IDs: "
    new_listings.each do |listing|
      puts "Listing Details: "
      puts listing["listing_id"]
      puts listing["title"]
      puts listing["when_made"]
      puts listing["description"]
      puts "\n\n"
    end

    # Add/Update Listings
    EtsyProduct.transaction do
      puts "Adding/updating new listings."
      listings.each do |listing|
        product = EtsyProduct.find_or_initialize_by(listing_id: listing["listing_id"])
        product.category_id = listing["listing_id"]
        product.shop_section_id = listing["shop_section_id"]
        product.title = listing["title"]
        product.description = listing["description"]
        product.price = listing["price"]
        product.currency_code = listing["currency_code"]
        product.quantity = listing["quantity"]
        product.tags = listing["tags"]
        product.category_path = listing["category_path"]
        product.taxonomy_path = listing["taxonomy_path"]
        product.materials = listing["materials"]
        product.featured_rank = listing["featured_rank"]
        product.url = listing["url"]
        product.views = listing["views"]
        product.num_favorers = listing["num_favorers"]
        product.shipping_template_id = listing["shipping_template_id"]
        product.shipping_profile_id = listing["shipping_profile_id"]
        product.registration_code = EtsyProduct.generate_registration_code if product.registration_code.blank?
        product.save!
      end
    end

    # add images for the new listings only
    if new_listings.count > 0
      EtsyProduct.transaction do
        puts "Adding images for the new listings."
        puts "There are #{new_listings.count} total new listings."

        new_listings.each do |listing|
          unless listing["when_made"] == "made_to_order"
            product = EtsyProduct.find_or_initialize_by(listing_id: listing["listing_id"])
            product.images = etsy_get_listing_images(listing["listing_id"])
            product.save!
          end
        end
      end
    end

    puts "Online presence updated! Great job :)"
  end

end