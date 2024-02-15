# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    city { Faker::Address.city }
    state { Faker::Address.state }
  end

  trait :with_reviews do
    after(:create) do |company|
      company.reviews << create(:review)
    end
  end
end
