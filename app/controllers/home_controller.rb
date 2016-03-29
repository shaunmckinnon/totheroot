class HomeController < ApplicationController

  def index
    respond_to do |format|
      format.json do
        @etsy_products = EtsyProduct.search(params[:term])
        render json: @etsy_products, status: :ok, message: 'Success'
      end
      
      format.html
    end
  end

end
