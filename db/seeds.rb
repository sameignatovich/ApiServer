require 'faker'
require 'avatarly'
require 'stringio'
require 'ruby-progressbar'

TOTAL_USERS=100
TOTAL_POSTS=1000
TOTAL_COMMENTS=10000

PROGRESS_FORMAT= '%e %P% |%b>%i| %c/%C'

# ========== USERS ==========
puts "Creating #{TOTAL_USERS} users"
users_progressbar = ProgressBar.create(title: "Users", format: PROGRESS_FORMAT, starting_at: 0, total: TOTAL_USERS)

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

user = User.create(
  username: 'sameignatovich',
  email: 'nikita@ignatovich.me',
  role: :admin,
  full_name: 'Nikita Ignatovich',
  password: '557322',
)
users_progressbar.finish

users_ids = User.ids

# ========== POSTS ==========
puts "Creating #{TOTAL_POSTS} posts"
posts_progressbar = ProgressBar.create(title: "Posts", format: PROGRESS_FORMAT, starting_at: 0, total: TOTAL_POSTS)

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
comments_progressbar = ProgressBar.create(title: "Comments", format: PROGRESS_FORMAT, starting_at: 0, total: TOTAL_COMMENTS)

TOTAL_COMMENTS.times do
  Comment.create(
    content: Faker::Lorem.paragraph,
    user_id: users_ids.sample,
    post_id: posts_ids.sample,
  )
  comments_progressbar.increment
end
