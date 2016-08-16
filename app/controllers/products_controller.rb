class ProductsController < ApplicationController

  def autocomplete_search
    respond_to do |format|
      format.json do
        render json: @etsy_products = EtsyProduct.search(params[:term])
      end
    end
  end

  def shop_section
    @shop_section = EtsyShopSection.find_by( shop_section_id: params[:shop_section_id] )
  end
  
end