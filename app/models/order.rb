class Order < ApplicationRecord
  validates :date, :status, presence: true
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  def total
    total = 0
    order_items.each do |oi|
      total += oi.subtotal
    end
    total
  end
end
