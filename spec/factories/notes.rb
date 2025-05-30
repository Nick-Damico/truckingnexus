FactoryBot.define do
  factory :note do
    user { create(:user) }
    body { Faker::Lorem.paragraph }
  end

  trait :with_geolocation do
    after(:create) do |note|
    end
  end
end
