# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserQuizzes::Results', type: :request do
  let!(:user) { create(:user) }
  let(:user_quiz) { create(:user_quiz, :with_completed_quiz, :with_graded_quiz, user:) }

  before { sign_in(user) }

  it_behaves_like 'Authorized Routes' do
    let(:authorized_routes) { [user_quizzes_result_path(user_quiz)] }
  end

  describe 'GET /show' do
    it 'returns http success' do
      get user_quizzes_result_path(user_quiz)

      expect(response).to have_http_status(:success)
    end
  end
end
