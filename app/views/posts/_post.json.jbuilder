json.extract! post, :id, :title, :text, :created_at, :updated_at
json.author do 
  json.user_id post.user.id
  json.username post.user.username
end
json.url post_url(post, format: :json)
