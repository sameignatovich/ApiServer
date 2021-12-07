json.extract! user, :id, :username, :full_name, :email, :role, :phone, :address, :posts_count, :comments_count, :created_at, :updated_at
json.avatar user.avatar.attached? ? polymorphic_url(user.avatar.variant(resize_to_limit: [500, 500])) : nil
