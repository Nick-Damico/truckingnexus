# frozen_string_literal: true

class AnswerSheet < ApplicationRecord
  belongs_to :user_quiz

  has_many :answer_sheet_questions
  has_many :questions, through: :answer_sheet_questions
  has_many :answers, through: :answer_sheet_questions

  def self.prep_for_quiz(user_quiz:)
    generate_answer_sheet_questions(AnswerSheet.find_or_create_by(user_quiz:))
  end

  def self.generate_answer_sheet_questions(answer_sheet)
    return nil unless answer_sheet && (quiz = answer_sheet.user_quiz.quiz)

    quiz.questions.each do |question|
      answer_sheet.answer_sheet_questions.create(question:)
    end
  end

  def completed?
    unanswered_question_count.zero?
  end

  def unanswered_question_count
    answer_sheet_questions.unanswered_questions.count
  end

  def next_question
    answer_sheet_questions.unanswered_questions.limit(1).first
  end
end
