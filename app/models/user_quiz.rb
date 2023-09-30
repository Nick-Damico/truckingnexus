# frozen_string_literal: true

class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz

  validates :user, presence: true
  validates :quiz, presence: true
end
