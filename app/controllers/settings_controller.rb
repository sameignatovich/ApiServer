class SettingsController < ApplicationController
  before_action :set_user

  # PATCH/PUT /settings/profile
  # PATCH/PUT /settings/profile.json
  def update_profile
    if @user.update(user_profile)
      render template: "authorization/autologin", status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /settings/avatar
  # PATCH/PUT /settings/avatar.json
  def update_avatar
    if @user.avatar.attach(user_avatar[:avatar])
      render json: { user: { avatar: polymorphic_url(@user.avatar.variant(:medium)) } }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /settings/password
  # PATCH/PUT /settings/password.json
  def update_password
    if @user.authenticate(user_passwords[:old_password])
      if @user.update(user_passwords.except(:old_password))
        render json: { updated: true }, status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: { old_password: ["Wrong current password"] }, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = Current.user
    end

    def user_profile
      params.require(:user).permit(:email, :full_name)
    end

    def user_avatar
      params.require(:user).permit(:avatar)
    end

    def user_passwords
      params.require(:user).permit(:old_password, :password, :password_confirmation)
    end
end