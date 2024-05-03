# frozen_string_literal: true

class AnswerSheetQuestion < ApplicationRecord
  belongs_to :answer, optional: true
  belongs_to :answer_sheet
  belongs_to :question

  scope :unanswered_questions, -> { where(answer_id: nil) }

  delegate :correct_answer, to: :question
end
