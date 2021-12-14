json.extract! post, :id, :title, :text, :comments_count, :created_at

json.tags do
  json.array! @tags, partial: "posts/tag", as: :tag
end

json.author do 
  json.user_id post.user.id
  json.username post.user.username
end
