# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quizzes', type: :request do
  let(:quiz) { build(:quiz) }
  let(:user) { create(:user) }

  it_behaves_like 'Authenticated Route' do
    let(:authenticated_routes) { [new_quiz_path] }
  end

  describe 'GET /quizzes' do
    it 'responds with HTTP status success(200)' do
      get quizzes_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /quizzes/new' do
    before { sign_in user }

    it 'responds with HTTP status success(200)' do
      get new_quiz_path

      expect(response).to have_http_status(:success)
    end

    it 'renders new template with form partial' do
      get new_quiz_path

      expect(response).to render_template('new')
      expect(response).to render_template(partial: '_form')
    end
  end

  describe 'POST /quizzes' do
    before { sign_in user }

    context 'valid params' do
      let(:valid_params) do
        { quiz: { author_id: user.id, name: quiz.name, description: quiz.description } }
      end

      it 'responds with HTTP status redirect(302)' do
        post(quizzes_path, params: valid_params)

        expect(response).to have_http_status(:redirect)
      end

      it 'creates a new record & redirects to show action' do
        expect do
          post(quizzes_path, params: valid_params)
        end.to change(Quiz, :count).by(1)

        expect(response).to redirect_to(quiz_path(assigns[:quiz]))
      end
    end

    context 'invalid params' do
      let(:invalid_params) do
        { quiz: { name: '', description: quiz.description } }
      end

      it 'does not create a new record & re-renders new form' do
        expect do
          post(quizzes_path, params: invalid_params)
        end.to change(Quiz, :count).by(0)

        expect(response).to render_template('new')
        expect(response).to render_template(partial: '_form')
        expect(flash[:alert]).to include("Name can't be blank")
      end

      it 'responds with HTTP status unprocessable entity(422)' do
        post(quizzes_path, params: invalid_params)

        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end
end
