# frozen_string_literal: true

class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_one :answer_sheet

  validates :user, presence: true
  validates :quiz, presence: true
end
