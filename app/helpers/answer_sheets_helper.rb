# frozen_string_literal: true

module AnswerSheetsHelper
  def correct_answer_count(answer_sheet)
    answer_sheet.correct_answer_count
  end

  def incorrect_answer_count(answer_sheet)
    answer_sheet.incorrect_answer_count
  end

  def total_question_count(answer_sheet)
    answer_sheet.number_of_questions
  end
end
