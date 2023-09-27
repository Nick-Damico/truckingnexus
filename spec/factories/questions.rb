# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    quiz { create(:quiz) }
    content { Faker::Lorem.sentence }
  end

  trait :with_answers do
    answers { create_list(:answer, 4) }
  end
end
