class Api::V1::Revenue::ItemsController < ApplicationController
  def index
    if params[:quantity].to_i  <= 0 || params[:quantity].to_i == nil
      render json: {error: 'That did not work'}, :nothing => true, :status => :bad_request
    else
      item  = Item.items_with_most_revenue(params[:quantity])
      render json: ItemRevenueSerializer.new(item)
    end
  end
end