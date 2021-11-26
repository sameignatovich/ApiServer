json.totalUsersCount @users_count
json.users do
  json.array! @users, partial: "users/user", as: :user
end
