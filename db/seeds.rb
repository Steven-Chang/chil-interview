# frozen_string_literal: true

require "open-uri"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_posts_for(user)
  return if user.posts.present?

  rand(1..5).times do |num|
    puts "."
    user.posts.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph(sentence_count: 77))
  end
end

puts "Creating subscription options"
SubscriptionOption.create(
  subscribable_type: "Post",
  description: "lifetime",
  price: 1
)

SubscriptionOption.create(
  subscribable_type: "Site",
  description: "yearly",
  price: 89.99
)

SubscriptionOption.create(
  subscribable_type: "Site",
  description: "yearly",
  price: 89.99
)

puts "== Creating Steven Hays =="
user1 = User.find_or_initialize_by(username: "steven").tap do |u|
  u.first_name = "Steven"
  u.last_name = "Hays"
  u.password = "Password123"
  u.email = "stevenhays@fakemail.com"
  u.username = "steven"
  u.save
end

puts "== Publishing for Steven Hays =="
create_posts_for(user1)

puts "== Creating Kimberly Green =="
user2 = User.find_or_initialize_by(username: "kim").tap do |u|
  u.first_name = "Kimberly"
  u.last_name = "Green"
  u.password = "Password123"
  u.email = "kimberlygreen@fakemail.com"
  u.username = "kim"
  u.save
end

puts "== Publishing for Kimberly Green =="
create_posts_for(user2)
