json.extract! comment, :id, :content, :user_id, :post_id, :created_at
json.content comment.content.to_s

json.author do
  json.user_id comment.user.id
  json.username comment.user.username
  json.avatar comment.user.avatar.attached? ? polymorphic_url(comment.user.avatar.variant(resize_to_limit: [64, 64])) : nil
end