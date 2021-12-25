json.extract! user, :id, :username, :full_name, :role, :obfuscated_email
json.avatar user.avatar.attached? ? polymorphic_url(user.avatar.variant(:thumb)) : nil
