class Api::V1::Revenue::SearchController < ApplicationController
  def unshipped
    order = Invoice.unshipped_orders(params[:quantity])
    render json: UnshippedOrderSerializer.new(order)
  end
end
