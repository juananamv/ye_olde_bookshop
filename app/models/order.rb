class Order < ApplicationRecord
  belongs_to :user

  validates :date, :status, presence: true
end
