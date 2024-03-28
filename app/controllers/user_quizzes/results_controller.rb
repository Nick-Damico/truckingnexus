# frozen_string_literal: true

module UserQuizzes
  class ResultsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_quiz
    before_action :authorize_user!

    def show; end

    private

    def authorize_user!
      return if @user_quiz.user == current_user

      redirect_to quizzes_url, flash: { alert: t('flash.unauthorized_access') }
    end

    def set_user_quiz
      @user_quiz = UserQuiz.find(params[:id])
    end
  end
end
