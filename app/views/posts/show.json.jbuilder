json.post do
  json.partial! "posts/post", post: @post
end

json.comments do
  json.array! @comments, partial: "comments/comment", as: :comment
end