# frozen_string_literal: true

FactoryBot.define do
  factory :quiz do
    author { create(:user) }
    name { "#{Faker::Lorem.sentence(word_count: 3)} Quiz" }
    description { Faker::Lorem.paragraph }
  end

  trait :with_questions do
    questions { create_list(:question, 1) }
  end
end
