# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.delete_all
ProductTag.delete_all
OrderItem.delete_all
Order.delete_all
User.delete_all
Province.delete_all
Product.delete_all
Category.delete_all

NUMBER_OF_CATEGORIES = 10
NUMBER_PER_CATEGORY = 15

NUMBER_OF_CATEGORIES.times do
  category = Category.create(name: Faker::Book.genre)

  NUMBER_PER_CATEGORY.times do
    product = category.products.create(
      name:             Faker::Book.title.unique,
      description:      "A #{category.name} novel written by #{Faker::Book.author}. #{rand 42..1532} pages.",
      price:            Faker::Commerce.price,
      quantity:         rand(3..22)
    )
  end
end

puts "Created #{Category.count} Categories"
puts "Created #{Product.count} Products"

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?