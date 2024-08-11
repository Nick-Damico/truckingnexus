# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompaniesHelper, type: :helper do
  include ReviewHelper

  describe '#rating' do
    it 'returns the average rating as star icons by default' do
      review = create(:review, rating: 4)
      company = create(:company, reviews: [review])

      expected_result = rating_stars(rating: company.rating)

      expect(rating(company)).to eq expected_result
    end

    it 'returns the average rating as a string when optional parameter display_with_icons is false' do
      review = create(:review, rating: 4)
      company = create(:company, reviews: [review])

      expect(rating(company, display_with_icons: false)).to eq '4 stars'
    end

    context 'has no reviews' do
      it 'returns string "No Reviews"' do
        company = create(:company)

        expect(rating(company)).to eq 'No Reviews'
      end
    end
  end
end
