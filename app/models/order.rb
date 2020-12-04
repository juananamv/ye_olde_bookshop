class Order < ApplicationRecord
  validates :date, :status, presence: true
  validates :gst, :pst, numericality: true
  belongs_to :user
  has_many :order_items, dependent: :destroy

  def total
    total = 0
    order_items.each do |oi|
      total += oi.subtotal
    end
    (total + gst + pst)
  end
end
