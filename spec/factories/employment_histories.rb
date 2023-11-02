# frozen_string_literal: true

FactoryBot.define do
  factory :employment_history do
    association :employee, factory: :user
    association :employer, factory: :company
    current { false }
  end
end
