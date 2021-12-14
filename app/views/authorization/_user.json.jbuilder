json.extract! user, :id, :username, :full_name, :role
json.avatar user.avatar.attached? ? polymorphic_url(user.avatar.variant(resize_to_limit: [500, 500])) : nil
