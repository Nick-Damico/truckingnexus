# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    city { Faker::Address.city }
    state { Faker::Address.state }
  end
end
