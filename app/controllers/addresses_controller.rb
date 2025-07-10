# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :set_address, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :verify_admin

  # GET /addresses or /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1 or /addresses/1.json
  def show; end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit; end

  # POST /addresses or /addresses.json
  def create
    @address = Address.new(address_params)
    super(@address) # Calls the create method from ApplicationController
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    super(@address, address_params) # Calls the update method from ApplicationController
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    super(@address, addresses_path) # Calls the destroy method from ApplicationController
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_address
    @address = Address.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def address_params
    params.require(:address).permit(:address)
  end
end
