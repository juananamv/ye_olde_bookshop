class Product < ApplicationRecord
  has_many :product_tags
  has_many :categories, through: :product_tags
  accepts_nested_attributes_for :product_tags, allow_destroy: true
  validates :name, :price, :quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { only_integer: true }
  has_one_attached :image
end