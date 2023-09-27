# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    question { create(:question) }
    content { Faker::Lorem.sentence }
  end
end
