class User < ApplicationRecord
  belongs_to :province
  validates :username, uniqueness: true
  validates :username, :password, :salt, :address, :city, :postal_code, presence: true
end
