# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Quiz, type: :model do
  subject { build(:quiz) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should belong_to(:author) }
  it { should have_many(:questions) }
  it { should have_many(:users).through(:user_quizzes) }

  context 'Validations' do
    it { should validate_presence_of(:author) }
  end

  it 'defaults to Draft true for new records' do
    subject.save

    expect(subject.draft).to eq true
  end
end
