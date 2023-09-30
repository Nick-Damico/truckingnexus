# frozen_string_literal: true

class Quiz < ApplicationRecord
  has_many :questions
  has_many :user_quizzes
  has_many :users, through: :user_quizzes

  validates :name, presence: true
  validates :name, uniqueness: true
end
