# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :quiz
  has_many :answers

  validates :content, presence: true
  validates :quiz, presence: true

  accepts_nested_attributes_for :answers

  def correct_answer
    answers.find_by_correct(true)
  end

  def build_answers(count = 2)
    count.times { @question.answers.build }
  end
end
