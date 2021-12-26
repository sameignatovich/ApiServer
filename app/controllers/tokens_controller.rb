class TokensController < ApplicationController
  before_action :check_authorization

  # GET /tokens
  # GET /tokens.json
  def index
    @tokens = current_user.tokens
  end

  # DELETE /tokens
  # DELETE /tokens.json
  def destroy
    token = current_user.tokens.find_by(id: params[:id], active: true)
    token.update(active: false)
  end
end