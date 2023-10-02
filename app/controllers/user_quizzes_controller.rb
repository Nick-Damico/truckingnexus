# frozen_string_literal: true

class UserQuizzesController < ApplicationController
  def new; end

  def create
    puts params
    @user_quiz = UserQuiz.create(user_quiz_params)
    if @user_quiz.save
      @user_quiz.prep_for_quiz
      redirect_to @user_quiz
    else
      redirect_to quizzes_url
    end
  end

  def show
    @user_quiz = UserQuiz.find_by(params[:user_quiz_id])
  end

  private

  def user_quiz_params
    params.require(:user_quiz).permit(:quiz_id, :user_id)
  end
end
