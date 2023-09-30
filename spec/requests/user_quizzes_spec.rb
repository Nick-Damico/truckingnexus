# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserQuizzes', type: :request do
  let!(:user) { create(:user) }
  let!(:quiz) { create(:quiz) }
  let!(:companies) { create_list(:company, 2) }

  before { sign_in user }

  let(:valid_params) do
    {
      user_quiz: {
        user_id: user.id, quiz_id: quiz.id
      }
    }
  end
  let(:invalid_params) do
    {
      user_quiz: {
        user_id: user.id, quiz_id: nil
      }
    }
  end

  describe 'GET /user_quizzes' do
    it 'returns a success status code' do
      get new_user_quiz_path(quiz)
      expect(response).to have_http_status(200)
    end
  end

  describe 'Create: POST /user_quizzes' do
    context 'successful' do
      it 'creates a resource' do
        expect do
          post user_quizzes_path, params: valid_params
        end.to change(UserQuiz, :count).by(1)
        expect(assigns[:user_quiz].quiz_id).to eq quiz.id
        expect(assigns[:user_quiz].user_id).to eq user.id
      end

      it 'redirects to new user_quiz' do
        post user_quizzes_path, params: valid_params
        user_quiz = assigns[:user_quiz]
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(user_quiz_path(user_quiz))
      end
    end

    context 'fails' do
      it 'does not create a resource' do
        expect do
          post user_quizzes_path, params: invalid_params
        end.to change(UserQuiz, :count).by(0)
      end

      it 'redirects to GET /quizzes url' do
        post user_quizzes_path, params: invalid_params
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(quizzes_url)
      end
    end
  end

  describe 'Show: GET /user_quiz' do
    it 'returns successful status code' do
      get user_quiz_path(subject)
      expect(response).to have_http_status(200)
    end
  end
end
