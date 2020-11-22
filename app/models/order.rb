class Order < ApplicationRecord
  validates :date, :status, presence: true
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items
end
