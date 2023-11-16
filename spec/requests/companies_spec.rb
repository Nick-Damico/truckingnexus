# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  let!(:companies) { create_list(:company, 2) }

  describe 'GET /companies' do
    it 'renders the index template' do
      get companies_path
      expect(response).to have_http_status(200)
      expect(response.body).to include(companies.first.name)
    end
  end

  describe 'GET /companies/:id' do
    it 'renders the show template' do
      selected_company = companies.first
      get company_path(selected_company)
      expect(response).to have_http_status(200)
      expect(response.body).to include(selected_company.name)
    end
  end
end
