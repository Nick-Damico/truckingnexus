# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserQuiz, type: :model do
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

  describe '#started_on' do
    it 'returns start DateTime value' do
      subject.prep_for_quiz
      expect(subject.started_on).to be_a(ActiveSupport::TimeWithZone)
    end
  end
end
