# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewHelper, type: :helper do
  describe '#active_star_class' do
    it 'returns class that styles an active rating star' do
      expect(active_star_class).to eq described_class::ACTIVE_STAR_CLASS
      expect(active_star_class).to_not be_nil
    end
  end

  describe '#rating_stars' do
    it 'renders star icons for specified count' do
      expected_count = 3

      expect(rating_stars(rating: 0, count: expected_count)).to have_selector('svg', count: expected_count)
    end

    it "renders stars with the 'active' CSS class for the provided rating" do
      expected_rating = 4
      expected_count = 5

      expect(rating_stars(rating: expected_rating,
                          count: expected_count)).to have_selector("svg.#{described_class::ACTIVE_STAR_CLASS}",
                                                                   count: expected_rating)
      expect(rating_stars(rating: expected_rating,
                          count: expected_count)).to have_selector('svg', count: expected_count)
    end
  end
end
