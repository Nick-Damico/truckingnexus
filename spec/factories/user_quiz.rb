# frozen_string_literal: true

FactoryBot.define do
  factory :user_quiz do
    user { create(:user) }
    quiz { create(:quiz) }
  end
end
