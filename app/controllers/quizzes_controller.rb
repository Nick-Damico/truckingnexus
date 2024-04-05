# frozen_string_literal: true

class QuizzesController < ApplicationController
  before_action :authenticate_user!, only: %i[new]

  def index
    @quizzes = Quiz.all
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)

    if @quiz.save
      redirect_to @quiz
    else
      flash.now[:alert] = @quiz.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:name, :description)
  end
end
