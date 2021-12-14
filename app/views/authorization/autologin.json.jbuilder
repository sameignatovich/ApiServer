json.loggedIn true

json.user do
  json.id @user.id
  json.username @user.username
  json.full_name @user.full_name
  json.role @user.role
  json.avatar @user.avatar.attached? ? polymorphic_url(@user.avatar.variant(resize_to_limit: [500, 500])) : nil
end
