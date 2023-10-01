# frozen_string_literal: true

class AnswerSheet < ApplicationRecord
  belongs_to :user_quiz

  has_many :answer_sheet_questions
  has_many :questions, through: :answer_sheet_questions
  has_many :answers, through: :answer_sheet_questions
end
