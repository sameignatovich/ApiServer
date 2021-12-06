class AuthorizationController < ApplicationController
  before_action :check_authorization, only: [:autologin, :signout]

  # POST /signin
  # POST /signin.json
  def signin
    @user = User.find_by_email(user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      token = @user.tokens.create(status: :active)
      render json: { token: ActiveJWT.encode(token.id), message: 'Signin successful' }, status: :ok
    else
      render json: {message: 'Wrong email or password'}, status: :unauthorized
    end
  end

  # POST /autologin
  # POST /autologin.json
  def autologin
    render json: { loggedIn: true }, status: :ok
  end

  # DELETE /signout
  # DELETE /signout.json
  def signout
    token = ApplicationJwt.decode(current_token)
    Token.find(token).inactive!
    render json: { signout: true }, status: :ok
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
