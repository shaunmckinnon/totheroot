class HomeController < ApplicationController

  def index
    respond_to do |format|
      format.json do
        @etsy_products = EtsyProduct.where("title ILIKE ?", "%#{params[:term]}%")params[:
   ]     File.open "test.json", "w" do |f|
          f.puts params.to_json
          f.puts @etsy_products.to_json
        end
        render json: @etsy_products
      end

      format.html
    end
  end

end
