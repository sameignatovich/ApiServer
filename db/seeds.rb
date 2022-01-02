require 'faker'
require 'avatarly'
require 'stringio'
require 'ruby-progressbar'

TOTAL_USERS=100
TOTAL_TOKENS=TOTAL_USERS*10
TOTAL_POSTS=TOTAL_USERS*10
TOTAL_COMMENTS=TOTAL_POSTS*10

PROGRESS_FORMAT= '%e %P% |%b>%i| %c/%C'

# ========== USERS ==========
puts "Creating #{TOTAL_USERS} users"
users_progressbar = ProgressBar.create(format: PROGRESS_FORMAT, starting_at: 0, total: TOTAL_USERS)

user = User.create(
  username: 'sameignatovich',
  email: 'nikita@ignatovich.me',
  role: :admin,
  full_name: 'Nikita Ignatovich',
  password: '557322',
)
users_progressbar.increment

(TOTAL_USERS-1).times do |i|
  user = User.create(
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    role: [:blocked, :regular].sample,
    full_name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
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

  users_progressbar.increment
end

users_ids = User.ids

# ========== TOKENS ==========
puts "Creating #{TOTAL_TOKENS} tokens"
tokens_progressbar = ProgressBar.create(format: PROGRESS_FORMAT, starting_at: 0, total: TOTAL_TOKENS)

TOTAL_TOKENS.times do
  Token.create(
    user_id: users_ids.sample,
    active: [true, false].sample,
    user_agent: Faker::Internet.user_agent,
    ip: [Faker::Internet.ip_v6_address, Faker::Internet.ip_v4_address].sample,
  )
  tokens_progressbar.increment
end


# ========== POSTS ==========
puts "Creating #{TOTAL_POSTS} posts"
posts_progressbar = ProgressBar.create(format: PROGRESS_FORMAT, starting_at: 0, total: TOTAL_POSTS)

TOTAL_POSTS.times do
  Post.create(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph(sentence_count: rand(100..150)),
    user_id: users_ids.sample,
    tags_list: Faker::Lorem.words(number: 5, supplemental: true)
  )
  posts_progressbar.increment
end

posts_ids = Post.ids

# ========== COMMENTS ==========
puts 'Creating 100.000 comments'
comments_progressbar = ProgressBar.create(format: PROGRESS_FORMAT, starting_at: 0, total: TOTAL_COMMENTS)

TOTAL_COMMENTS.times do
  Comment.create(
    content: Faker::Lorem.paragraph,
    user_id: users_ids.sample,
    post_id: posts_ids.sample,
  )
  comments_progressbar.increment
end
