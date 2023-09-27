# frozen_string_literal: true

FactoryBot.define do
  factory :quiz do
    name { "#{Faker::Lorem.sentence(word_count: 3)} Quiz" }
  end

  trait :with_questions do
    questions { create_list(:question, 1) }
  end
end
