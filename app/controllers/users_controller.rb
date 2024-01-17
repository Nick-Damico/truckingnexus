# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'dashboard'

  UPDATE_MSG = 'Updated information successfully'

  before_action :set_user, only: %i[show update]
  before_action :set_resources, only: %i[show]

  def show
    @page_content = params[:page_content]
  end

  def update
    return unless @user.update(user_params)

    if params_has_current_employer?(user_params)
      EmploymentHistoryManager.new(
        employee: @user,
        employer: params_current_employer(user_params)
      ).call
    end

    redirect_to @user, flash: { notice: UPDATE_MSG }
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      employment_histories_attributes: %i[current employer_id]
    )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_resources
    @companies = Company.order(:name)
    @employment_history = EmploymentHistory.new(current: true)
    @current_employer = @user.current_employer
  end

  def params_has_current_employer?(user_params)
    return false unless employment_history_params(user_params).present?

    employment_history_params(user_params).values.any? { |attrs| attrs['current'] }
  end

  def params_current_employer(user_params)
    return nil unless params_has_current_employer?(user_params)

    return unless (cur_employer_attrs = employment_history_params(user_params).values.find { |attrs| attrs['current'] })

    Company.find_by(id: cur_employer_attrs['employer_id'])
  end

  def employment_history_params(user_params)
    user_params[:employment_histories_attributes]
  end
end
