# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Quiz, type: :model do
  subject { build(:quiz) }
  it { should have_many(:questions) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
