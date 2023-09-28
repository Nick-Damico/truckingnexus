# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { create(:question) }

  it { should belong_to(:correct_answer).optional }
  it { should belong_to(:quiz) }
  it { should have_many(:answers) }

  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:quiz) }

  it 'should have a valid factory' do
    expect(subject).to be_valid
  end
end
