# frozen_string_literal: true

RSpec.describe UserQuiz, type: :model do
  subject { create(:user_quiz) }

  it { should belong_to(:user) }
  it { should belong_to(:quiz) }
  it { should have_one(:answer_sheet) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:quiz) }

  describe '#generate_answer_sheet' do
    it 'user answer_sheet for quiz' do
      expect(subject.answer_sheet)
    end
  end
end
