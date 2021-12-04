# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'Creating 1.000 users'
1000.times do
	user = User.create(
		username: Faker::Internet.unique.username,
		email: Faker::Internet.unique.email,
		phone: Faker::PhoneNumber.cell_phone_with_country_code,
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		address: Faker::Address.full_address,
		password: Faker::Internet.password,
	)

  img = Avatarly.generate_avatar("User #{user.id}", {
  	size: 1000,
  	font_size: 100,
  	format: 'png',
  	separator: ''
  })

  ioObj = StringIO.new(img)

	user.avatar.attach(io: ioObj, filename: "#{user.id}.png", content_type: "image/png")
end

puts 'Creating 10.000 posts'
10000.times do
	Post.create(
		title: Faker::Lorem.sentence,
		text: Faker::Lorem.paragraph(sentence_count: rand(50..100)),
		user_id: rand(1..1000),
	)
end

puts 'Creating 100.000 comments'
100000.times do
	Comment.create(
		body: Faker::Lorem.paragraph,
		user_id: rand(1..1000),
		post_id: rand(1..10000),
		parent_id: :null
	)
end