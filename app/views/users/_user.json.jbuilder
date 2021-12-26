json.extract! user, :id, :username, :role, :full_name, :posts_count, :comments_count, :created_at, :updated_at
json.avatar user.avatar.attached? ? polymorphic_url(user.avatar.variant(:medium)) : nil