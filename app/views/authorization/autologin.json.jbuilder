json.loggedIn true

json.user do
  json.partial! "authorization/user", user: @user
end
