# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quizzes', type: :request do
  # let!(:companies) { create_list(:company, 2) }

  describe 'GET /quizzes' do
    it 'responds with status success' do
      get quizzes_path
      expect(response).to have_http_status(200)
    end
  end
end
