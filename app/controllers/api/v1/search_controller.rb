class Api::V1::SearchController < ApplicationController
  def find
    merchant = Merchant.find_by("name LIKE ?", "%#{params[:name].downcase}%")
    if merchant == nil
      render json: {"data" => {}}
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end