# frozen_string_literal: true

class Quiz < ApplicationRecord
  # TODO: Replace with database field
  #       Each quiz should have a passing_score
  #       that can be configured.
  PASSING_SCORE = 70

  has_many :questions
  has_many :user_quizzes
  has_many :users, through: :user_quizzes

  validates :name, presence: true
  validates :name, uniqueness: true
end
