# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Quiz, type: :model do
  subject { build(:quiz) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:questions) }
  it { should have_many(:users).through(:user_quizzes) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end
end
