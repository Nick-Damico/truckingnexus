require 'rails_helper'

RSpec.describe 'UserQuizzes::Results', type: :request do
  describe 'GET /show' do
    it 'returns http success' do
      get '/user_quizzes/results/show'
      expect(response).to have_http_status(:success)
    end
  end
end
