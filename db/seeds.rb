require 'faker'
require 'avatarly'
require 'stringio'

puts 'Creating 1.000 users'
1000.times do |i|
	user = User.create(
		username: Faker::Internet.unique.username,
		email: Faker::Internet.unique.email,
		role: :regular,
		phone: Faker::PhoneNumber.cell_phone_with_country_code,
		full_name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
		address: Faker::Address.full_address,
		password: Faker::Internet.password,
	)

  img = Avatarly.generate_avatar("User #{i+1}", {
  	size: 1000,
  	font_size: 100,
  	format: 'png',
  	separator: ''
  })

  ioObj = StringIO.new(img)

	user.avatar.attach(io: ioObj, filename: "#{user.id}.png", content_type: "image/png")
end

users_ids = User.ids

puts 'Creating 10.000 posts'
10000.times do
	Post.create(
		title: Faker::Lorem.sentence,
		text: Faker::Lorem.paragraph(sentence_count: rand(50..100)),
		user_id: users_ids.sample,
	)
end

posts_ids = Post.ids

puts 'Creating 100.000 comments'
100000.times do
	Comment.create(
		body: Faker::Lorem.paragraph,
		user_id: users_ids.sample,
		post_id: posts_ids.sample,
		parent_id: :null
	)
end