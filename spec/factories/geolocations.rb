
FactoryBot.define do
  factory :geolocation do
    name { Faker::Address.full_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
