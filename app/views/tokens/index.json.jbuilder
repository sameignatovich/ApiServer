json.tokens do
  json.array! @tokens, partial: "tokens/token", as: :token
end
