# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:review) { creat(:review) }

  it { should have_db_column(:reviewable_id) }
  it { should have_db_column(:reviewable_type) }
  it { should belong_to(:reviewer) }

  describe 'Validations' do
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }

    it 'permits 1 review from a Reviwer for a Reviewable( Company )' do
      review1 = create(:review, rating: 4)

      dup_review = review1.dup
      dup_review.rating = 1

      expect(dup_review).to be_invalid
      # Enforced at DB
      expect { dup_review.save(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    context '#rating' do
      it 'is valid with a rating between 1 and 5' do
        review = build(:review, rating: 3)

        expect(review).to be_valid
      end

      it 'is invalid with a rating less than 1 or greater than 5' do
        invalid_review = build(:review, rating: 100)

        expect(invalid_review).to_not be_valid
        expect(invalid_review.errors).to include(:rating)
        expect(invalid_review.errors[:rating]).to include(described_class::INVALID_RATING_MESSAGE)
      end

      it 'must be an integer' do
        invalid_review = build(:review, rating: 1.4)

        expect(invalid_review).to_not be_valid
        expect(invalid_review.errors).to include(:rating)
      end
    end
  end

  describe '.rating_for(reviewable)' do
    context 'has reviews' do
      it 'returns average rating' do
        company = create(:company)

        ratings = [4, 5, 3]
        ratings.each do |rating|
          company.reviews << create(:review, rating:)
        end

        expected_rating = (ratings.sum / ratings.count).round

        expect(described_class.rating_for(company)).to eq(expected_rating)
      end
    end
    context 'no reviews' do
      it "returns no rating default value #{described_class::NO_RATING_DEFAULT_VALUE}" do
        company = create(:company)

        expect(described_class.rating_for(company)).to eq(described_class::NO_RATING_DEFAULT_VALUE)
      end
    end
  end
end
