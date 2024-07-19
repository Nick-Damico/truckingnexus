# frozen_string_literal: true

FactoryBot.define do
  factory :driver_log do
    driver { create(:user) }
  end
end
