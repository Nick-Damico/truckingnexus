# frozen_string_literal: true

FactoryBot.define do
  factory :quiz do
    name { "#{Faker::Hobby.activity} Quiz" }
  end

  trait :with_questions do
    questions { create_list(:question, 2) }
  end
end
