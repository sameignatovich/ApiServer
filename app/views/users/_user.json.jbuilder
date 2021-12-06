json.extract! user, :id, :username, :email, :role, :phone, :first_name, :last_name, :address, :posts_count, :comments_count, :created_at, :updated_at
json.avatar user.avatar.attached? ? polymorphic_url(user.avatar.variant(resize_to_limit: [500, 500])) : nil
