class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  belongs_to :merchant

  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.items_with_most_revenue(quantity)

    item_quantity = quantity.to_i
    Item.select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .joins(invoice_items: [:invoice, :transactions])
    .where(transactions: {result: "success"}, invoice: {status: "shipped"})
    .group("items.id")
    .order("revenue desc")
    .limit(item_quantity)
  end
end
