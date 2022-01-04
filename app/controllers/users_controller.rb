class UsersController < ApplicationController
  before_action :check_authorization
  before_action :set_user, only: %i[ show update destroy ]
  before_action :set_current_user, only: %i[ update_current_user update_current_user_avatar update_current_user_password ]

  has_scope :role, only: %i[ index ]

  # GET /users
  # GET /users.json
  def index
    @users = apply_scopes(User).page(params[:page])
                               .per(params[:perPage])
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

  # PATCH/PUT /current/profile
  # PATCH/PUT /current/profile.json
  def update_current_user
    if @user.update(user_params_update_current_user)
      render template: "authorization/autologin", status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /current/avatar
  # PATCH/PUT /current/avatar.json
  def update_current_user_avatar
    if @user.avatar.attach(user_params_update_current_avatar[:avatar])
      render json: { user: { avatar: polymorphic_url(@user.avatar.variant(:medium)) } }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /current/password
  # PATCH/PUT /current/password.json
  def update_current_user_password
    if @user.authenticate(user_params_update_current_password[:old_password])
      if @user.update(user_params_update_current_password.except(:old_password))
        render json: { updated: true }, status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: { old_password: ["Wrong current password"] }, status: :unprocessable_entity
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

    def set_current_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:username, :email, :full_name, :password, :password_confirmation)
    end

    def user_params_update_current_user
      params.require(:user).permit(:email, :full_name)
    end

    def user_params_update_current_avatar
      params.require(:user).permit(:avatar)
    end

    def user_params_update_current_password
      params.require(:user).permit(:old_password, :password, :password_confirmation)
    end
end
