# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'reviews/index', type: :view do
  subject { create(:company, :with_reviews) }

  context 'with review' do
    let(:reviews) { subject.reviews }
    before do
      assign(:reviews, reviews)

      render
    end

    it 'displays reviewer username' do
      expect(rendered).to have_content(reviews.first.reviewer.username)
    end

    it 'displays review title' do
      expect(rendered).to have_content(reviews.first.title)
    end

    it 'displays review rating' do
      expect(rendered).to have_content(reviews.first.rating.to_f)
    end

    it 'displays review content' do
      expect(rendered).to have_content(reviews.first.content)
    end

    describe 'edit link' do
      context 'review belongs to user' do
        it 'displays link' do
          review = subject.reviews.first
          sign_in review.reviewer

          render

          expect(rendered).to have_link 'Edit', href: edit_company_review_path(subject, review)
        end
      end

      context 'review does not belong to user' do
        it 'does not display' do
          review = subject.reviews.first
          sign_in create(:user)

          render

          expect(rendered).to_not have_link 'Edit', href: edit_company_review_path(subject, review)
        end
      end
    end

    describe 'delete button' do
      context 'review belongs to user' do
        it 'displays button' do
          review = subject.reviews.first
          sign_in review.reviewer

          render

          expect(rendered).to have_selector("form[action='#{company_review_path(subject, review)}'][method='post']")
          expect(rendered).to have_selector(:button, text: 'Delete')
        end
      end
      context 'review does not belong to user' do
        it 'does not display button' do
          review = subject.reviews.first
          sign_in create(:user)

          render

          expect(rendered).to_not have_selector("form[action='#{company_review_path(subject, review)}'][method='post']")
          expect(rendered).to_not have_selector(:button, text: 'Delete')
        end
      end
    end
  end

  context 'no reviews' do
    it 'displays no reviews message' do
      assign(:reviews, Review.none)

      render

      expect(rendered).to match(/no one has left a review yet/i)
    end
  end
end
