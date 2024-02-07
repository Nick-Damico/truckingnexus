# frozen_string_literal: true

module UserQuizzes::ResultsHelper
  PASSED_MESSAGE = 'Congratulations, You Passed!'
  FAILED_MESSAGE = "You did not Pass. You must score #{::Quiz::PASSING_SCORE}% or higher.".freeze

  def result_msg(user_quiz)
    user_quiz.passed? ? PASSED_MESSAGE : FAILED_MESSAGE
  end
end
