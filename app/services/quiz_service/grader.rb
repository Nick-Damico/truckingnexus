# frozen_string_literal: true

module QuizService
  class Grader
    attr_accessor :user_quiz, :answer_sheet
    attr_reader :grade

    def initialize(user_quiz:)
      @user_quiz = user_quiz
      @answer_sheet = @user_quiz.answer_sheet
    end

    def call
      grade_quiz
      save_grade
    end

    private

    def grade_quiz
      calculate_grade_percentage
    end

    def calculate_grade_percentage
      @grade = (number_of_correct_answers.to_f / number_of_questions * 100.to_f).round
    end

    def number_of_correct_answers
      answer_sheet.number_of_correct_answers
    end

    def number_of_questions
      answer_sheet.number_of_questions
    end

    def save_grade
      user_quiz.update(score: @grade)
    end
  end
end
