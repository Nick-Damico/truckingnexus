# frozen_string_literal: true

class UserQuizzesController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_user_quiz, only: %i[show destroy]
  before_action :set_user, only: %i[index]
  before_action :authorize_user!, except: %i[index create]

  def index
    @user_quizzes = UserQuiz.where(user: current_user)
  end

  ##
  # The controllers 'create' action is the starting
  # point for a new UserQuiz. There is no need for
  # a new form at this time.
  #
  # This process is initiated by the
  # QuizzesHelper.quiz_start_button, which calls
  # 'create' with the required resources.
  def create
    @user_quiz = UserQuiz.new(user_quiz_params)
    if @user_quiz.save
      @user_quiz.prep_for_quiz
      redirect_to @user_quiz
    else
      redirect_to quizzes_url
    end
  end

  def show
    if @user_quiz.completed?
      grade_quiz unless @user_quiz.graded?
      redirect_to user_quizzes_result_url(@user_quiz)
    end

    set_show_variables
  end

  def destroy
    return unless @user_quiz.destroy

    redirect_to quizzes_url
  end

  private

  def authorize_user!
    return if @user && @user == current_user
    return if @user_quiz.user == current_user

    redirect_to quizzes_url, flash: { alert: t('flash.unauthorized_access') }
  end

  def grade_quiz
    return unless @user_quiz.completed?

    QuizService::Grader.new(user_quiz: @user_quiz).call
  end

  def set_show_variables
    @answer_sheet = @user_quiz.answer_sheet
  end

  def set_user_quiz
    @user_quiz = UserQuiz.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_quiz_params
    params.require(:user_quiz).permit(:quiz_id, :user_id)
  end
end
