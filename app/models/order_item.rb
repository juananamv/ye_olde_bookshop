class OrderItem < ApplicationRecord
  belongs_to :order

  validates :product_name, presence: true
  validates :count, numericality: { only_integer: true }
  validates :subtotal, numericality: { greater_than_or_equal_to: 0 }
end
