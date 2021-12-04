json.extract! comment, :body, :parent_id, :created_at, :updated_at

json.author do 
  json.user_id comment.user.id
  json.username comment.user.username
  json.avatar comment.user.avatar.attached? ? polymorphic_url(comment.user.avatar.variant(resize_to_limit: [64, 64])) : nil
end
