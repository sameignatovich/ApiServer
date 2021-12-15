class UsersController < ApplicationController
  before_action :check_authorization
  before_action :set_user, only: %i[ show update destroy ]

  has_scope :role, only: :index

  # GET /users
  # GET /users.json
  def index
    @users = apply_scopes(User).page(params[:page])
                               .per(params[:perPage])
    @users_count = apply_scopes(User).count
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
  end

  # GET /users/1/posts
  # GET /users/1/posts.json
  def posts
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :first_name, :last_name, :address, :password, :password_confirmation)
    end
end
