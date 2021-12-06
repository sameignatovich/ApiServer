class ApplicationController < ActionController::API
  def check_authorization
    render json: { message: 'Unauthorized' }, status: :unauthorized unless !!current_user
  end

  def current_user
    Token.find_by(id: ActiveJWT.decode(current_token), status: :active).user
  end

  def current_token
    #header: { 'Authorization': 'Bearer <token>' }
    request.headers['Authorization'].split(' ')[1]
  end
end
