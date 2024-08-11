# frozen_string_literal: true

FactoryBot.define do
  factory :driver_log do
    driver { create(:user, :with_current_employer) }
    company { driver.current_employer }
  end
end
