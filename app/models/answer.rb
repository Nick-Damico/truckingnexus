# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  validates :content, presence: true
  validates :content,
            uniqueness: { scope: :question_id, case_sensitive: false,
                          message: 'answer has already been taken' }

  scope :correct, -> { where(correct: true) }
end
