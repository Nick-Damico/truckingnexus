# frozen_string_literal: true

RSpec.describe UserQuiz, type: :model do
  subject { create(:user_quiz) }

  it { should belong_to(:user) }
  it { should belong_to(:quiz) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:quiz) }
end
