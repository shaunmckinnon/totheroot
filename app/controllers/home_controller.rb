require 'etsy_product'

class HomeController < ApplicationController

  def index
    respond_to do |format|
      @etsy_products = EtsyProduct.search(params[:term])

      format.json do
        render json: @etsy_products
      end

      format.html
    end
  end

end
