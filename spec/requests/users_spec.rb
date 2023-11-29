# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  subject(:user) { create(:user) }

  before { sign_in user }

  describe 'GET /show' do
    it 'returns http success' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end
end
