json.extract! user, :id, :username, :email, :phone, :first_name, :last_name, :address, :created_at, :updated_at
json.url user_url(user, format: :json)
