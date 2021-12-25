class TokensController < ApplicationController
  before_action :check_authorization

  # GET /tokens
  # GET /tokens.json
  def index
    @tokens = current_user.tokens
  end
end