# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  # GET /addresses or /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1 or /addresses/1.json
  def show
    address
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
    address
  end

  # POST /addresses or /addresses.json
  def create
    new_address = Address.new(address_params)

    respond_to do |format|
      if new_address.save
        format.html { redirect_to new_address, notice: I18n.t('addresses.create.notice') }
        format.json { render :show, status: :created, location: new_address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: new_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    respond_to do |format|
      if address.update(address_params)
        format.html { redirect_to address, notice: I18n.t('addresses.update.notice') }
        format.json { render :show, status: :ok, location: address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    address.destroy!

    respond_to do |format|
      format.html { redirect_to addresses_path, status: :see_other, notice: I18n.t('addresses.destroy.notice') }
      format.json { head :no_content }
    end
  end

  private

  # Memoize the address lookup to avoid multiple database queries.
  def address
    @address ||= Address.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def address_params
    params.require(:address).permit(:address)
  end
end
