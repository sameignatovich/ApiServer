class AuthorizationController < ApplicationController
  before_action :check_authorization, only: %i[ autologin signout ]

  # POST /signin
  # POST /signin.json
  def signin
    @user = User.find_by_email(user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      if @user.admin?
        new_token = @user.tokens.create(active: :true, user_agent: request.user_agent, ip: request.ip)
        @token = ActiveJWT.encode(new_token.id)
      elsif @user.regular?
        render json: {message: 'Access denied'}, status: :unauthorized
      elsif @user.blocked?
        render json: {message: 'You are blocked'}, status: :unauthorized
      end
    else
      render json: {message: 'Wrong email or password'}, status: :unauthorized
    end
  end

  # POST /autologin
  # POST /autologin.json
  def autologin
    @user = Current.user
  end

  # DELETE /signout
  # DELETE /signout.json
  def signout
    Token.find(current_token_id).update(active: false)
    render json: { signout: true }, status: :ok
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
