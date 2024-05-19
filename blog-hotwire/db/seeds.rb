# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
user = User.create!(email: 'test@test.com', password: 'foobar', password_confirmation: 'foobar', confirmed_at: Time.now, confirmation_sent_at: Time.now)

10.times do |_i|
  user.posts.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph(sentence_count: 100))
end

10.times do |i|
  user = User.create!(
    email: Faker::Internet.email,
    username: "#{Faker::Name.first_name} " + "#{Faker::Name.last_name}",
    password: 'password',
    password_confirmation: 'password'
  )

  10.times do |_j|
    user.posts.create!(
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph(sentence_count: 100)
    )
  end

  puts "User #{i + 1} created. with 10 posts"
end
