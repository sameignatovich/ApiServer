json.token @token

json.user do
  json.partial! "authorization/user", user: @user
end
