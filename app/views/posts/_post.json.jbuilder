json.extract! post, :id, :title, :content, :comments_count, :created_at
json.content post.content.to_s

json.author do
  json.user_id post.user.id
  json.username post.user.username
end

json.tags do
  json.array! @tags, partial: "tags/tag", as: :tag
end
