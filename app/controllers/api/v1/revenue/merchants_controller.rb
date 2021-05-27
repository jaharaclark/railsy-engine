class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    merchant = Merchant.merchants_with_most_revenue(params[:quantity])
    #  I need to make a serializer for "merchant_name_revenue", it then becomes the type. 
  end

  def show

  end
end