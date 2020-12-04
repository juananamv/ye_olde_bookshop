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

NUMBER_OF_CATEGORIES = 6
NUMBER_PER_CATEGORY = 20

filename = Rails.root.join("db/province_info.csv")
province_data = File.read(filename)
provinces = CSV.parse(province_data, headers: true, encoding: "utf-8")

provinces.each do |p|
  Province.create(
    name:          p["name"],
    province_code: p["province_code"],
    gst:           p["gst"],
    pst:           p["pst"]
  )
end

NUMBER_OF_CATEGORIES.times do
  category = Category.create(name: Faker::Book.unique.genre)

  NUMBER_PER_CATEGORY.times do
    product = category.products.create(
      name:        Faker::Book.unique.title,
      description: "A #{category.name} novel written by #{Faker::Book.author}. #{rand 42..1532} pages.",
      price:       Faker::Commerce.price,
      quantity:    rand(3..22)
    )
    # Uncomment for final
    downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{product.name}")
    product.image.attach(io: downloaded_image, filename: "m-#{product.name}")
  end
end

puts "Created #{Category.count} Categories"
puts "Created #{Product.count} Products"

if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password")
end
