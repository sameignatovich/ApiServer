class ApplicationController < ActionController::API

  private
  
  def check_authorization
    render json: { message: 'Authorization required' }, status: :unauthorized unless !!authentication
  end

  def authentication
    token = current_token_id ? Token.find_by(id: current_token_id, active: true) : nil

    if token
      token.touch
      Current.user = token.user
    end
  end

  def current_token_id
    #headers: { 'Authorization': 'Bearer <token>' }
    jwt = request.headers['Authorization']
    jwt ? ActiveJWT.decode(jwt.split(' ')[1]) : nil
  end
end
