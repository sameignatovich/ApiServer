require 'faker'
require 'avatarly'
require 'stringio'

puts 'Creating 1.000 users'
999.times do |i|
	user = User.create(
		username: Faker::Internet.unique.username,
		email: Faker::Internet.unique.email,
		role: [:banned, :regular].sample,
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

user = User.create(
	username: 'sameignatovich',
	email: 'nikita@ignatovich.me',
	role: :admin,
	phone: '+375 (29) 655-19-84',
	full_name: 'Nikita Ignatovich',
	address: '223710 Belarus, Minsk region, Soligorsk',
	password: '557322',
)

users_ids = User.ids

puts 'Creating 10.000 posts'
10000.times do
	Post.create(
		title: Faker::Lorem.sentence,
		text: Faker::Lorem.paragraph(sentence_count: rand(50..100)),
		user_id: users_ids.sample,
		tags_list: Faker::Lorem.words(number: 5, supplemental: true)
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