# frozen_string_literal: true

class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_one :answer_sheet, dependent: :destroy

  validates :user, presence: true
  validates :quiz, presence: true

  scope :active, -> { where(score: nil) }
  scope :completed, -> { where.not(score: nil) }

  delegate :answer_sheet_questions, to: :answer_sheet

  def prep_for_quiz
    return answer_sheet if answer_sheet.present?

    AnswerSheet.prep_for_quiz(user_quiz: self)
  end

  def active?
    false if answer_sheet.nil?

    !answer_sheet.completed?
  end

  def completed?
    false if answer_sheet.nil?

    answer_sheet.completed?
  end

  def started_on
    answer_sheet&.created_at
  end

  def completed_at
    # TODO: Add a completed at/on DateTime stamp;
    # Using the updated_could be inaccurate a .touch can modify this.
    answer_sheet&.updated_at
  end
end
