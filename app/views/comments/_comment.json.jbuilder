json.extract! comment, :body, :parent_id, :created_at, :updated_at

json.author do 
  json.user_id comment.user.id
  json.username comment.user.username
end

json.post do 
  json.post_id comment.post_id
end