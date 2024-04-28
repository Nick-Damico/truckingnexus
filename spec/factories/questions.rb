# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    quiz { create(:quiz) }
    content { Faker::Lorem.sentence }

    after(:build) do |question, _evaluator|
      question.answers << build(:answer, correct: true)
      question.answers << build(:answer)
    end
  end
end
