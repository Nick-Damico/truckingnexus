# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_quiz, only: %i[create edit index new]
  before_action :set_question, only: %i[edit]

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

  def edit; end

  def update; end

  private

  def question_params
    params.require(:question).permit(:content, :quiz_id, answers_attributes: %i[content])
  end

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
