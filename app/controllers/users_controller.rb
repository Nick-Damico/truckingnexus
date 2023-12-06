# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'dashboard'

  before_action :set_user, only: %i[show update]
  before_action :set_resources, only: %i[show]

  def show
    @page_content = params[:page_content]
  end

  def update
    return unless @user.update(user_params)

    redirect_to @user, flash: { notice: 'Updated Successfully' }
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      employment_histories_attributes: [:employer_id]
    )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_resources
    @companies = Company.order(:name)
    @employment_history = EmploymentHistory.new(current: true)
  end
end
