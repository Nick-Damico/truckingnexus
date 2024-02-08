# frozen_string_literal: true

# TODO: Do not finalize quiz with a score if all answers are not completed.
module QuizService
  class GradingError < StandardError; end

  class Grader
    attr_accessor :user_quiz, :answer_sheet
    attr_reader :grade

    def initialize(user_quiz:)
      raise GradingError, "Cannot grade incomplete UserQuiz: #{user_quiz.id}" unless user_quiz.completed?

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
