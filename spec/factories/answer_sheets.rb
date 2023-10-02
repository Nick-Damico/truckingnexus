FactoryBot.define do
  factory :answer_sheet do
    user_quiz { create(:user_quiz) }
  end
end
