json.extract! user, :id, :username, :email, :phone, :first_name, :last_name, :address, :created_at, :updated_at
json.avatar user.avatar.attached? ? polymorphic_url(user.avatar.variant(resize_to_limit: [500, 500])) : nil
