# frozen_string_literal: true

class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_one :answer_sheet, dependent: :destroy

  validates :user, presence: true
  validates :quiz, presence: true

  scope :active, -> { where(score: nil) }

  def prep_for_quiz(question_count: nil)
    return answer_sheet if answer_sheet.present?

    AnswerSheet.prep_for_quiz(user_quiz: self)
  end

  def completed?
    false if answer_sheet.nil?

    answer_sheet.completed?
  end

  def started_on
    answer_sheet&.created_at
  end
end
