# frozen_string_literal: true

require 'rails_helper'

class UserQuiz < ApplicationRecord
  self.table_name = 'quizzes_users'

  belongs_to :user
  belongs_to :quiz

  validates :user, presence: true
  validates :quiz, presence: true
end
