class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.merchants_with_most_revenue(quantity)
    merchant_limit = quantity.to_i
    Merchant.select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .group("merchants.id")
    .order("revenue desc")
    .limit(merchant_limit)
  end
  
  def self.total_revenue
  joins(invoices: [:invoice_items, :transactions])
    .where("transactions.result = 'success' AND invoices.status = 'shipped'")
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .group(:id)
    .order("revenue desc")
  end
end
