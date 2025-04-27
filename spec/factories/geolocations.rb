FactoryBot.define do
  factory :geolocation do
    name { Faker::Address.full_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    association :locatable, factory: :note

    # trait :for_note do
    #   association :locatable, factory: :note
    # end
  end
end
