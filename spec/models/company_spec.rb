# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { build(:company) }

  it { should have_many(:employees).through(:employment_histories) }
  it { should have_many(:reviews) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
