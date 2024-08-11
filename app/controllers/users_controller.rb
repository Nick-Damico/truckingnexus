# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'dashboard'

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

    redirect_to user_url(@user, page_content: params[:page_content]),
                flash: { notice: t('flash.users.update.success') }
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
    case params[:page_content]
    when 'profile'
      @companies          = Company.order(:name)
      @employment_history = EmploymentHistory.new(current: true)
      @current_employer   = @user.current_employer
    when 'quizzes'
      @authored_quizzes   = @user.authored_quizzes
      @active_quizzes     = @user.user_quizzes.active
      @completed_quizzes  = @user.user_quizzes.completed_last_30_days.order(completed_at: :desc)
    end
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
