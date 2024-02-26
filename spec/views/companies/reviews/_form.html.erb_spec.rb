# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'companies/reviews/_form', type: :view do
  let(:user) { create(:user) }
  let(:company) { create(:company) }

  before do
    sign_in user

    assign(:review, create(:review, reviewer: user, reviewable: company))

    render
  end

  xit 'displays a form element' do
    expect(rendered).to have_content(user.username)
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
