# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { create(:company) }

  it { should have_many(:employees).through(:employment_histories) }
  it { should have_many(:reviews) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe '#average_rating' do
    it 'returns the average rating based on User reviews' do
      subject

      ratings = [4, 5, 3]
      ratings.each do |rating|
        subject.reviews << create(:review, rating:)
      end

      expected_rating = (ratings.sum / ratings.count).round

      expect(subject.reviews.count).to eq ratings.count
      expect(subject.rating).to eq(expected_rating)
    end
  end
end
