json.extract! user, :id, :username, :full_name, :role, :email
json.avatar user.avatar.attached? ? polymorphic_url(user.avatar.variant(:thumb)) : nil
