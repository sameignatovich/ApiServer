# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'Creating 100 users'
100.times do
	User.create(
		username: Faker::Internet.unique.username,
		email: Faker::Internet.unique.email,
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		address: Faker::Address.full_address,
		password: Faker::Internet.password,
	)
end

puts 'Creating 1000 posts'
1000.times do
	Post.create(
		title: Faker::Lorem.sentence,
		text: Faker::Lorem.paragraph,
		user_id: rand(1..100),
	)
end