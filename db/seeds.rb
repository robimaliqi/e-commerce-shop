# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
48.times do
  product_name = Faker::Commerce.unique.product_name.split.last(2).join(' ')
  photo = Unsplash::Photo.search(product_name).first
  product = Product.create(
    name: product_name,
    description: Faker::Lorem.sentence,
    image: photo.urls.regular,
    price: Faker::Commerce.price(range: 0..1000.0, as_string: false)
  )
  puts "Product '#{product.name}' created with ID #{product.id} and image related to '#{product_name}'"
end