class MerchantsController < ApplicationController
  before_action :set_merchant, only: %i[ show edit update destroy ]

  # GET /merchants or /merchants.json
  def index
    authorize Merchant
    @merchants = Merchant.all
  end

  # GET /merchants/1 or /merchants/1.json
  def show
  end

  # GET /merchants/1/edit
  def edit
    authorize Merchant
  end

  # PATCH/PUT /merchants/1 or /merchants/1.json
  def update
    authorize Merchant
    respond_to do |format|
      if @merchant.update(merchant_params)
        format.html { redirect_to merchant_url(@merchant), notice: "Merchant was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /merchants/1 or /merchants/1.json
  def destroy
    authorize Merchant
    notice = if @merchant.authorize_transactions.any?
      "Unable to destroy: merchant is related to a payment transaction!"
    else
      @merchant.destroy
      "Merchant was successfully destroyed."
    end
    respond_to do |format|
      format.html { redirect_to merchants_url, notice: }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def merchant_params
      params.require(:merchant).permit(:id, :name, :email, :description, :status)
    end
end
