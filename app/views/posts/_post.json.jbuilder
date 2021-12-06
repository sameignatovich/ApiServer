json.extract! post, :id, :title, :text, :comments_count, :created_at
json.author do 
  json.user_id post.user.id
  json.username post.user.username
end
