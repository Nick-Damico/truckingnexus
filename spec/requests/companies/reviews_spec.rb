# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies/Review Requests', type: :request do
  let(:user) { create(:user) }
  let(:company) { create(:company, :with_reviews) }

  before { sign_in user }

  describe 'GET /companies/:company_id/reviews' do
    it 'render template index with HTTP success' do
      get company_reviews_path(company)

      expect(response).to render_template('reviews/index')
      expect(response).to have_http_status(:success)
    end
  end
end
