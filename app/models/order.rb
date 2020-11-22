class Order < ApplicationRecord
  validates :date, :status, presence: true
end
