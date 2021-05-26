class Api::V1::ItemsController < ApplicationController
  def index
    per_page = (params[:per_page] || 20).to_i 
    if params[:page].to_i >= 1
      page = (params[:page] || 1).to_i 
    else
      page = 1
    end
    items = Item.limit(per_page).offset(((page - 1) * per_page))
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  def create
    render json: Item.create(item_params)
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end