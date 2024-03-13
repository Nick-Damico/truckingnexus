# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies/Review Requests', type: :request do
  let(:user) { create(:user) }
  let!(:company) { create(:company, :with_reviews) }

  before { sign_in user }

  let(:valid_params) do
    {
      review: {
        reviewer_id: user.id,
        reviewable_id: company.id,
        reviewable_type: 'Company',
        title: Faker::Name.name,
        content: Faker::Lorem.sentence(word_count: 3),
        rating: [*(1..5)].sample
      }
    }
  end

  describe 'GET /companies/:company_id/reviews' do
    it 'render template index with HTTP success' do
      get company_reviews_path(company)

      expect(response).to render_template('reviews/index')
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /companies/:company_id/reviews/new' do
    it 'renders partial form with HTTP success' do
      get new_company_review_path(company)

      expect(response).to have_http_status(:success)
      expect(response).to render_template('new')
      expect(response).to render_template(partial: '_form')
    end
  end

  describe 'POST /companies/:company_id/reviews/create' do
    context 'valid params' do
      it 'creates a review for the provided company' do
        expect do
          post company_reviews_path(company), params: valid_params
        end.to change(Review, :count).by(1)
      end

      it 'redirects to reviewable :show action with HTTP status :redirect' do
        post company_reviews_path(company), params: valid_params

        expect(response).to redirect_to(company)
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'GET /companies/:company_id/reviews/:id' do
    it 'renders show template with HTTP status success' do
      get polymorphic_url([company, company.reviews.last])

      expect(response).to render_template('show')
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /companies/:company_id/edit' do
    it 'renders form with HTTP status :success' do
      review_to_edit = company.reviews.first

      get edit_company_review_path(company, review_to_edit)

      expect(response).to render_template('edit')
      expect(response).to render_template(partial: '_form')
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /companies/:company_id/review/:id' do
    it 'updates resource' do
      review = company.reviews.first
      params = { review: review.attributes.merge('rating' => '1') }

      expect do
        patch polymorphic_url([company, company.reviews.last]), params:
      end.to change(Review, :count).by(0)

      expect(review.reload.rating).to eq 1
    end
  end
end
