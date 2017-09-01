class ShopSectionsController < ApplicationController
  before_action :admin_check
  before_action :set_shop_section, only: [:show, :edit, :update, :destroy]

  # admin check
  def admin_check
    authenticate_user!

    if current_user.email != Rails.application.secrets.gmail_login
      redirect_to "/"
    end
  end

  # GET /shop_sections
  # GET /shop_sections.json
  def index
    @shop_sections = ShopSection.all
  end

  # GET /shop_sections/1
  # GET /shop_sections/1.json
  def show
  end

  # GET /shop_sections/new
  def new
    @shop_section = ShopSection.new
  end

  # GET /shop_sections/1/edit
  def edit
  end

  # POST /shop_sections
  # POST /shop_sections.json
  def create
    @shop_section = ShopSection.new(shop_section_params)

    respond_to do |format|
      if @shop_section.save
        format.html { redirect_to @shop_section, notice: 'Shop section was successfully created.' }
        format.json { render :show, status: :created, location: @shop_section }
      else
        format.html { render :new }
        format.json { render json: @shop_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop_sections/1
  # PATCH/PUT /shop_sections/1.json
  def update
    respond_to do |format|
      if @shop_section.update(shop_section_params)
        format.html { redirect_to @shop_section, notice: 'Shop section was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop_section }
      else
        format.html { render :edit }
        format.json { render json: @shop_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop_sections/1
  # DELETE /shop_sections/1.json
  def destroy
    @shop_section.destroy
    respond_to do |format|
      format.html { redirect_to shop_sections_url, notice: 'Shop section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop_section
      @shop_section = ShopSection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_section_params
      params.require(:shop_section).permit(:name, :description, :etsy_shop_section_id)
    end
end
