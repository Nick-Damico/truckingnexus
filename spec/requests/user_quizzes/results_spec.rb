require 'rails_helper'

RSpec.describe 'UserQuizzes::Results', type: :request do
  describe 'GET /show' do
    it 'returns http success' do
      user_quiz = create(:user_quiz, :completed)
      get user_quizzes_result_path(user_quiz)

      expect(response).to have_http_status(:success)
    end
  end
end
