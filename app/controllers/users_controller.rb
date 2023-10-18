# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update]

  def show; end

  def update
    return unless @user.update(user_params)

    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
