# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    quiz { create(:quiz) }
    content { Faker::Lorem.sentence }

    after(:build) do |question, _evaluator|
      answers = build_list(:answer, 2)
      answers.first.correct = true

      question.answers << answers
    end
  end
end
