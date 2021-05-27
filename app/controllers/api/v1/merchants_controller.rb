class Api::V1::MerchantsController < ApplicationController
  def index
    per_page = (params[:per_page] || 20).to_i 
    if params[:page].to_i >= 1
      page = (params[:page] || 1).to_i 
    else
      page = 1
    end
    merchants = Merchant.limit(per_page).offset(((page - 1) * per_page))
    render json: MerchantSerializer.new(merchants)
  end
  
  def show
    # if params[:id] == "find"
    #   merchant = Merchant.find_by("name LIKE ?", "%#{params[:name].downcase}%")
    #   if merchant == nil
    #     render json: {"data" => {}}
    #   end
    # else
      merchant = Merchant.find(params[:id])
    # end
    render json: MerchantSerializer.new(merchant)
  end
end
