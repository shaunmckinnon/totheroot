class HomeController < ApplicationController

  def index
    respond_to do |format|
      format.json do
        @etsy_products = EtsyProduct.search(params[:term])
        File.open "/tmp/test.json", "w" do |f|
          f.puts @etsy_products.to_json
        end
        render json: @etsy_products
      end

      format.html
    end
  end

end
