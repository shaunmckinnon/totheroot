class ProductController < ApplicationController

  def autocomplete_search
    respond_to do |format|
      format.json do
        render json: @etsy_products = EtsyProduct.search(params[:term])
      end
    end
  end
  
end