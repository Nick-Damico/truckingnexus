# frozen_string_literal: true

class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_one :answer_sheet

  validates :user, presence: true
  validates :quiz, presence: true

  def prep_for_quiz(question_count: nil)
    return answer_sheet if answer_sheet.present?

    AnswerSheet.prep_for_quiz(user_quiz: self)
  end

  def completed?
    false if answer_sheet.nil?

    answer_sheet.completed?
  end
end
