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
end
