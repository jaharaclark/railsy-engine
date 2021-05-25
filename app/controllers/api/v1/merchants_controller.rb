class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end 
  
  def show
    render json: Merchant.find(params[:id])
  end
end


#  def index
#     per_page = (params[:per_page] || 20).to_i 
#     page = (params[:page] || 1).to_i 
#     merchants = Merchant.limit(per_page).offset(((page - 1) * per_page))
#     render json: MerchantSerializer.new(merchants)
#   end