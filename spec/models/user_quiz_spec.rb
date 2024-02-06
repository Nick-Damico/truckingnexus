# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserQuiz, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  subject { create(:user_quiz) }

  it { should belong_to(:user) }
  it { should belong_to(:quiz) }
  it { should have_one(:answer_sheet) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:quiz) }

  describe '#prep_for_quiz' do
    it 'generates an AnswerSheet' do
      subject.prep_for_quiz
      expect(subject.answer_sheet).to_not be_nil
    end
  end

  describe '#completed_last_30_days' do
    it 'returns UserQuizzes completed in the last month' do
      # Create a quiz completed today
      create(:user_quiz, :with_completed_quiz, :with_graded_quiz)

      old_quiz = create(:user_quiz, :with_completed_quiz, :with_graded_quiz)
      old_quiz.update_column(:completed_at, Date.current.months_ago(2))

      expect(UserQuiz.completed_last_30_days).to_not include(old_quiz)
    end
  end

  describe '#started_at' do
    it 'returns start DateTime value' do
      subject.prep_for_quiz
      expect(subject.started_at).to be_a(ActiveSupport::TimeWithZone)
    end
  end

  describe '#completed_at' do
    context 'incomplete quiz' do
      it 'returns nil' do
        expect(subject.completed_at).to be nil
      end
    end

    it 'returns the completed DateTime' do
      expected_time = Time.current

      freeze_time do
        user_quiz = create(:user_quiz, :with_completed_quiz, :with_graded_quiz)
        expect(user_quiz.completed_at).to be_a(ActiveSupport::TimeWithZone)
        expect(user_quiz.completed_at.to_s).to eq expected_time.to_s
      end
    end
  end

  describe '#active?' do
    it 'returns true if UserQuiz is active' do
      active_user_quiz = create(:user_quiz, :active)
      expect(active_user_quiz.active?).to eq true
    end
  end

  describe '#completed?' do
    it 'returns true if UserQuiz is completed' do
      completed_user_quiz = create(:user_quiz, :with_completed_quiz)
      expect(completed_user_quiz.completed?).to eq true
    end
  end
end
