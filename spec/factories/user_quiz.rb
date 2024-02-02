# frozen_string_literal: true

FactoryBot.define do
  factory :user_quiz do
    user { create(:user) }
    quiz { create(:quiz, :with_questions) }
  end

  trait :active do
    after(:create) do |user_quiz, _eval|
      user_quiz.prep_for_quiz
    end
  end

  trait :with_completed_quiz do
    after(:create) do |user_quiz, _eval|
      user_quiz.prep_for_quiz
      user_quiz.answer_sheet_questions.each do |as_question|
        as_question.update(answer: as_question.question.correct_answer)
      end
    end
  end

  trait :with_graded_quiz do
    with_completed_quiz
    after(:create) do |user_quiz, _eval|
      QuizService::Grader.new(user_quiz:).call
    end
  end
end
