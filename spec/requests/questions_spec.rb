# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  let(:quiz) { create(:quiz, :with_questions) }
  let(:quiz_author) { quiz.author }

  # it_behaves_like 'Authenticated Route' do
  #   let(:authenticated_routes) { [new_question_path] }
  # end

  describe 'GET quzzies/:quiz_id/questions' do
    it 'responds with HTTP status success(200)' do
      get quiz_questions_path(quiz)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /quizzes/:quiz_id/questions/new' do
    before { sign_in quiz_author }

    it 'responds with HTTP status success(200)' do
      get new_quiz_question_path(quiz)

      expect(response).to have_http_status(:success)
    end

    it 'renders new template with form partial' do
      get new_quiz_question_path(quiz)

      expect(response).to render_template('new')
      expect(response).to render_template(partial: '_form')
    end
  end

  describe 'GET /quizzes/:quiz_id/questions/:id/edit' do
    it 'responds with HTTP Status success(200)' do
      get edit_quiz_question_path(quiz, quiz.questions.first)

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /quizzes/:quiz_id/questions' do
    before { sign_in quiz_author }

    context 'valid params' do
      let(:valid_params) do
        { question: { content: 'Is it Safe?', quiz_id: quiz.id,
                      answers_attributes: { '0': { content: 'Foo' }, '1': { content: 'Bar' } } } }
      end

      it 'responds with HTTP status redirect(302)' do
        post(quiz_questions_path(quiz), params: valid_params)

        expect(response).to have_http_status(:redirect)
      end

      it 'creates a new record & redirects to show action' do
        expect do
          post(quiz_questions_path(quiz), params: valid_params)
        end.to change(Question, :count).by(1).and change(Answer, :count).by(2)

        expect(response).to redirect_to(quiz_path(assigns[:quiz]))
        expect(flash[:notice]).to eq 'Question was successfully created'
      end
    end

    context 'invalid params' do
      let(:invalid_params) do
        { question: { content: '', quiz_id: quiz.id } }
      end

      it 'does not create a new record & re-renders new form' do
        expect do
          post(quiz_questions_path(quiz), params: invalid_params)
        end.to change(Question, :count).by(0)

        expect(response).to render_template('new')
        expect(response).to render_template(partial: '_form')
      end

      it 'responds with HTTP status unprocessable entity(422)' do
        post(quiz_questions_path(quiz), params: invalid_params)

        expect(response).to have_http_status(422)
        expect(flash.now[:alert]).to_not be_empty
      end
    end
  end
end
