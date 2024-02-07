# frozen_string_literal: true

class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_one :answer_sheet, dependent: :destroy

  validates :user, presence: true
  validates :quiz, presence: true

  scope :active, -> { where(score: nil) }
  scope :completed, -> { where.not(score: nil) }
  scope :completed_last_30_days, -> { completed.where('completed_at >= ?', 30.days.ago) }

  delegate :answer_sheet_questions, to: :answer_sheet

  def prep_for_quiz
    return answer_sheet if answer_sheet.present?

    AnswerSheet.prep_for_quiz(user_quiz: self)
  end

  def active?
    return false if answer_sheet.nil?

    !answer_sheet.completed?
  end

  def completed?
    return false if answer_sheet.nil?

    answer_sheet.completed?
  end

  def graded?
    !!score && !!completed_at
  end

  def passed?
    return false unless score

    score >= Quiz::PASSING_SCORE
  end

  def started_at
    answer_sheet&.created_at
  end
end
