class ProductsController < ApplicationController

  before_action :admin_check, only: [:edit]
  before_action :set_etsy_product, only: [:details, :edit, :update, :set_etsy_product]

  def autocomplete_search
    respond_to do |format|
      format.json do
        render json: @etsy_products = EtsyProduct.search(params[:term])
      end
    end
  end

  def shop_section
    @shop_section = EtsyShopSection.find_by( slug: params[:slug] )
  end

  def details
  end

  def edit
  end

  def update
    respond_to do |format|
      if @details.update(etsy_product_params)
        format.html { redirect_to "/products/#{@details.etsy_shop_section.title}/#{@details.id}", notice: 'Product Details were successfully updated.' }
        format.json { render :show, status: :ok, location: "/products/#{@details.etsy_shop_section.slug}/#{@details.id}" }
      else
        format.html { render :edit }
        format.json { render json: @details.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_etsy_product
      @details = EtsyProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def etsy_product_params
      params.require(:etsy_product).permit(:title, :description, :price)
    end
end