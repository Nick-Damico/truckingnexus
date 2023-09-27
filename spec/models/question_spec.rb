# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { create(:question) }

  it { belong_to(:quiz) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:quiz) }

  it 'should have a valid factory' do
    expect(subject).to be_valid
  end
end
