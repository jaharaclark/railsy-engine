class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity].to_i == (0 || nil)
      render json: {error: 'That did not work'}, :nothing => true, :status => :bad_request
    else
      merchant = Merchant.merchants_with_most_revenue(params[:quantity])
      render json: MerchantNameRevenueSerializer.new(merchant)
    end
  end

  def show
    merchant = Merchant.total_revenue.find(params[:id])
    render json: MerchantRevenueSerializer.new(merchant)
  end
end