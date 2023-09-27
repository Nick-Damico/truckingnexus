# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    quiz { create(:quiz) }
    content { Faker::Lorem.sentence }

    after(:build) do |question, _evaluator|
      question.answers << build_list(:answer, 4)
      question.correct_answer = question.answers.first
    end
  end
end
