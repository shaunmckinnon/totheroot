class HomeController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json do
        @etsy_products = EtsyProduct.search(params[:term])
        render json: @etsy_products, status: :ok, message: 'Success'
      end
      format.js do
        @etsy_products = EtsyProduct.search(params[:term])
        render json: @etsy_products, status: :ok, message: 'Success'
      end
    end
  end

end
