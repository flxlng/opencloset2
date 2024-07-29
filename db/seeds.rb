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
    # fake_image = Faker::LoremFlickr.image(size: "300x300", search_terms: ['product'])
    # Upload the image to Cloudinary
    # uploaded_image = Cloudinary::Uploader.upload("../../assets/images/seed_image.jpg")

    piece = user.pieces.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      color: Faker::Color.color_name,
      # photos: uploaded_image['https://res.cloudinary.com/dvnfimkfd/image/upload/c_fill,h_300,w_400/v1/development/kajf60ttzev7hyvesbc07wty626t?_a=BACCd2Bn']
    )
    puts "Created piece: #{piece.name}"
  end
end

puts "Seed completed successfully!"
