class UsersController < ApplicationController
  before_action :check_authorization
  before_action :set_user, only: %i[ show update destroy ]

  has_scope :role, only: %i[ index ]

  # GET /users
  # GET /users.json
  def index
    @users = apply_scopes(User).page(params[:page] || 1)
                               .per(params[:count] || 10)
                               .with_attached_avatar
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
      render :show, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render :show, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
  end

  private
    def set_user
      @user = User.find_by_username(params[:username])
    end

    def user_params
      params.require(:user).permit(:username, :email, :full_name, :password, :password_confirmation)
    end
end
