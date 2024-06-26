# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { create(:question) }

  it { should belong_to(:quiz) }
  it { should have_many(:answers) }

  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:quiz) }

  it 'should have a valid factory' do
    expect(subject).to be_valid
  end

  describe '#correct_answer' do
    it 'returns correct answer' do
      expect(subject.correct_answer.correct?).to eq true
    end
  end
end
