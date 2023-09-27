# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    quiz { create(:quiz) }
    content { Faker::Lorem.sentence }
  end
end
