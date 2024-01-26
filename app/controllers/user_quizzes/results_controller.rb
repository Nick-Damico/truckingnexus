# frozen_string_literal: true

module UserQuizzes
  class ResultsController < ApplicationController
    before_action :set_user_quiz, only: %i[show]

    def show; end

    private

    def set_user_quiz
      @user_quiz = UserQuiz.find(params[:id])
    end
  end
end
