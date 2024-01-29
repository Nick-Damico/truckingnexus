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

    it 'returns a datetime with timezone' do
      expected_datetime = Time.zone.now
      freeze_time do
        subject.update_column(:completed_at, expected_datetime)
        expect(subject.completed_at.to_s).to eq expected_datetime.to_s
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
      completed_user_quiz = create(:user_quiz, :completed)
      expect(completed_user_quiz.completed?).to eq true
    end
  end
end
