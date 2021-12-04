json.users do
  json.users_count @users_count
  json.last_user @last_user, partial: "users/user", as: :user
end

json.posts do
  json.posts_count @posts_count
  json.last_post @last_post, partial: "posts/post", as: :post
end

json.comments do
  json.comments_count @comments_count
  json.last_comment @last_comment, partial: "comments/comment", as: :comment
end