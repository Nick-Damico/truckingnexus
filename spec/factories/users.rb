# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
  end

  trait :with_current_employer do
    employment_histories { create_list(:employment_history, 1, current: true) }
  end
end
