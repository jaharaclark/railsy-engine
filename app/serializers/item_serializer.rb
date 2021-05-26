class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :unit_price, :merchant_id
  # attribute :merchant_id, if: proc {|record, params| 
  #   params[:merchant_item] == true
  # } 
end
