class ApplicationController < ActionController::API

  private
  
  def check_authorization
    render json: { message: 'Authorization required' }, status: :unauthorized unless !!current_user
  end

  def current_user
    current_token ? Token.find_by(id: ActiveJWT.decode(current_token), status: :active).user : nil
  end

  def current_token
    #headers: { 'Authorization': 'Bearer <token>' }
    jwt = request.headers['Authorization']
    jwt ? jwt.split(' ')[1] : nil
  end
end
