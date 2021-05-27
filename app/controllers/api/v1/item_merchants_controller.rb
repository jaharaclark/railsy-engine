class Api::V1::ItemMerchantsController < ApplicationController
  def index
    merchant = Item.find(params[:item_id]).merchant
    render json: MerchantSerializer.new(merchant)
  end
end