class Product < ApplicationRecord
  has_many :product_tags
  has_many :categories, through: :product_tags
  accepts_nested_attributes_for :product_tags, allow_destroy: true
end
