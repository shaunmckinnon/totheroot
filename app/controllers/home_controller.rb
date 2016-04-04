require 'etsy_product'

class HomeController < ApplicationController

  def index
    @featured = EtsyProduct.featured
  end

end
