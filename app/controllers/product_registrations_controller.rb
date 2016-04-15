class ProductRegistrationsController < ApplicationController
  before_action :set_product_registration, only: [:show, :edit, :update, :destroy]
  layout "product_registration"

  # GET /product_registrations
  # GET /product_registrations.json
  def index
    @product_registrations = ProductRegistration.all
  end

  # GET /product_registrations/1
  # GET /product_registrations/1.json
  def show
  end

  # GET /product_registrations/new
  def new
    @product_registration = ProductRegistration.new
  end

  # GET /product_registrations/1/edit
  def edit
  end

  # POST /product_registrations
  # POST /product_registrations.json
  def create
    @product_registration = ProductRegistration.new(product_registration_params)

    respond_to do |format|
      if @product_registration.save
        format.html { redirect_to @product_registration, notice: 'Product registration was successfully created.' }
        format.json { render :show, status: :created, location: @product_registration }
      else
        format.html { render :new }
        format.json { render json: @product_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_registrations/1
  # PATCH/PUT /product_registrations/1.json
  def update
    respond_to do |format|
      if @product_registration.update(product_registration_params)
        format.html { redirect_to @product_registration, notice: 'Product registration was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_registration }
      else
        format.html { render :edit }
        format.json { render json: @product_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_registrations/1
  # DELETE /product_registrations/1.json
  def destroy
    @product_registration.destroy
    respond_to do |format|
      format.html { redirect_to product_registrations_url, notice: 'Product registration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_registration
      @product_registration = ProductRegistration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_registration_params
      params.require(:product_registration).permit(:first_name, :last_name, :product_name, :product_number, :phone_number, :address_line_1, :address_line_2, :postal_code, :city, :province, :country, :email, :registration_number, :date_of_manufacture)
    end
end
