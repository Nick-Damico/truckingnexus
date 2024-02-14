# frozen_string_literal :true

FactoryBot.define do
  factory :review do
    reviewer { create(:user) }
    rating { 5 }
    content { Faker::Lorem.paragraph(sentence_count: 2) }
    title { Faker::Quote.famous_last_words }
    reviewable { create(:company) }
  end
end
