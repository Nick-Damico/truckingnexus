# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_quiz, only: %i[index create]
  def index; end


  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end
end
