class Api::V1::SearchController < ApplicationController
  def find
    merchant = Merchant.find_by("name LIKE ?", "%#{params[:name].downcase}%")
    if merchant == nil
      render json: {"data" => {}}
    else
      render json: MerchantSerializer.new(merchant)
    end
  end

  def find_all
     item = Item.find_by("name LIKE ?", "%#{params[:name].downcase}%")
    if item == nil
      render json: {"data" => {}}
    else
      render json: ItemSerializer.new(item)
    end
  end
end