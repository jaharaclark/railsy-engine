class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has many :invoices
  has_many :invoices_items, through: :items
  has_many :transactions, through: :items
  has_many :customers, through: :invoices
end
