# frozen_string_literal: true

module QuizService
  class GradingError < StandardError; end

  class Grader
    attr_accessor :user_quiz, :answer_sheet
    attr_reader :grade

    def initialize(user_quiz:)
      unless user_quiz.completed?
        raise GradingError,
              "#{self.class.name} Cannot grade incomplete UserQuiz: #{user_quiz.id}"
      end

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
      @grade = (correct_answer_count.to_f / number_of_questions * 100.to_f).round
    end

    def correct_answer_count
      answer_sheet.correct_answer_count
    end

    def number_of_questions
      answer_sheet.number_of_questions
    end

    def save_grade
      user_quiz.update(
        score: @grade,
        completed_at: DateTime.current
      )
    end
  end
end
