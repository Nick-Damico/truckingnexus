# frozen_string_literal: true

class AnswerSheetQuestionsController < ApplicationController
  before_action :set_answer_sheet_question, only: %i[update]

  def update
    return unless @answer_sheet_question.update(answer_sheet_question_params)

    redirect_to @answer_sheet_question.answer_sheet.user_quiz
  rescue ActionController::ParameterMissing
    flash.alert = AnswerSheet::ANSWER_ERROR_MSG
    redirect_to @answer_sheet_question.answer_sheet.user_quiz
  end

  private

  def answer_sheet_question_params
    params.require(:answer_sheet_question).permit(:id, :answer_id)
  end

  def set_answer_sheet_question
    @answer_sheet_question = AnswerSheetQuestion.find_by(id: params[:id])
  end
end
