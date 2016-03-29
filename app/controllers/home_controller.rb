require 'etsy_product'

class HomeController < ApplicationController

  def index
    respond_to do |format|
      format.html

      format.json do
        render json: @etsy_products = EtsyProduct.search(params[:term])
      end
    end
  end

end
