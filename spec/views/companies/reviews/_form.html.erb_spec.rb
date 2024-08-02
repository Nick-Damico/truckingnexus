# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'companies/reviews/_form', type: :view do
  let(:user) { create(:user) }
  let(:company) { create(:company) }

  before do
    sign_in user

    review = build(:review, reviewer: user, reviewable: company, created_at: Time.current)

    render locals: { review:, reviewable: company }
  end

  context 'New Review' do
    it 'displays a current date/time' do
      expect(rendered).to have_content(Time.current.strftime('%b %d, %Y'))
    end
  end

  # context 'with review' do
  #   let(:reviews) { subject.reviews }
  #   before do
  #     assign(:reviews, reviews)

  #     render
  #   end

  #   it 'displays review username' do
  #     expect(rendered).to have_content(reviews.first.reviewer.username)
  #   end

  #   it 'displays review title' do
  #     expect(rendered).to have_content(reviews.first.title)
  #   end

  #   it 'displays reviewers rating' do
  #     expect(rendered).to have_content(reviews.first.rating.to_f)
  #   end

  #   it 'displays review content' do
  #     expect(rendered).to have_content(reviews.first.content)
  #   end
  # end

  # context 'no reviews' do
  #   it 'displays no reviews message' do
  #     assign(:reviews, Review.none)

  #     render

  #     expect(rendered).to match(/no one has left a review yet/i)
  #   end
  # end
end
