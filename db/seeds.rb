# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data
puts "Clearing existing data..."
Piece.destroy_all
User.destroy_all

# Create 3 users
puts "Creating users..."
user = User.create!(
  email: "felixlong224@gmail.com",
  password: "123456"
)
3.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8)
  )

  puts "Created user: #{user.email}"

  # Create 3 pieces for each user
  puts "Creating pieces for #{user.email}..."
  3.times do
    piece = user.pieces.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      color: Faker::Color.color_name
    )
    puts "Created piece: #{piece.name}"
  end
end

puts "Seed completed successfully!"
