# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_quiz, only: %i[index create new]
  def index; end

  def new
    @question = @quiz.questions.build
  end

  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html do
          redirect_to @question.quiz, notice: t('flash.successfully_created', model_name: @question.class.name)
        end
      else
        format.html do
          flash.now[:alert] = @question.errors.full_messages
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def question_params
    params.require(:question).permit(:content, :quiz_id, answers_attributes: %i[content])
  end

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end
end
