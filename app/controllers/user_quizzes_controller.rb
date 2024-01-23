# frozen_string_literal: true

class UserQuizzesController < ApplicationController
  before_action :set_user_quiz, only: %i[show destroy]
  before_action :set_user, only: %i[index]

  def index
    @user_quizzes = UserQuiz.where(user: current_user)
  end

  def new; end

  def create
    @user_quiz = UserQuiz.create(user_quiz_params)
    if @user_quiz.save
      # TODO: Should prep_for_quiz belong in a after_save callback?
      @user_quiz.prep_for_quiz
      redirect_to @user_quiz
    else
      redirect_to quizzes_url
    end
  end

  def show
    prep_for_quiz
    set_show_variables
    grade_quiz if @user_quiz.completed?
  end

  def destroy
    return unless @user_quiz.destroy

    redirect_to quizzes_url
  end

  private

  def grade_quiz
    return if @user_quiz.score.present?

    QuizService::Grader.new(user_quiz: @user_quiz).call
  end

  def prep_for_quiz
    @user_quiz.prep_for_quiz unless @user_quiz.answer_sheet
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
