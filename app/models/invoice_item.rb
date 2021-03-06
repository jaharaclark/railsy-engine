class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price

  belongs_to :invoice
  belongs_to :item
  has_many :transactions, through: :invoice
end