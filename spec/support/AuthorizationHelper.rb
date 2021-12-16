module AuthorizationHelper
  def create_user_token(user)
    token = user.tokens.create.id
    return ActiveJWT.encode(token)
  end
end