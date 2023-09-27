# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quizzes', type: :request do
  # let!(:companies) { create_list(:company, 2) }

  describe 'GET /quizzes' do
    it 'renders the index template' do
      get quizzes_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('CDL Quizzes')
    end
  end
end
