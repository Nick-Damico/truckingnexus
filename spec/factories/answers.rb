# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    content { Faker::Lorem.sentence }
  end
end
