# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'dashboard'

  UPDATE_MSG = 'Updated information successfully'

  before_action :authenticate_user!
  before_action :set_user, only: %i[show update]
  before_action :authorize_user!
  before_action :set_resources, only: %i[show update]

  def show
    @page_content = params[:page_content]
  end

  def update
    unless @user.update(user_params)
      flash.now[:alert] = @user.errors.full_messages
      render 'edit'
      return
    end

    if params_has_current_employer?
      EmploymentHistoryManager.new(
        employee: @user,
        employer: params_current_employer
      ).call
    end

    redirect_to @user, flash: { notice: UPDATE_MSG }
  end

  private

  def authorize_user!
    return if @user == current_user

    redirect_to current_user, flash: { alert: t('flash.unauthorized_access') }
  end

  def user_params
    params.require(:user).permit(
      :username,
      :avatar,
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

  def params_has_current_employer?
    return false unless employment_history_params.present?

    employment_history_params.values.any? { |attrs| attrs['current'] }
  end

  def params_current_employer
    return nil unless params_has_current_employer?

    return unless (cur_employer_attrs = employment_history_params.values.find { |attrs| attrs['current'] })

    Company.find_by(id: cur_employer_attrs['employer_id'])
  end

  def employment_history_params
    user_params[:employment_histories_attributes]&.reject { |_, v| v[:employer_id].blank? }
  end
end
