# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quizzes', type: :request do
  let(:user) { create(:user) }

  it_behaves_like 'Authenticated Route' do
    let(:authenticated_routes) { [new_quiz_path] }
  end

  describe 'GET /quizzes' do
    it 'responds with HTTP status success(200)' do
      get quizzes_path

      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /quizzes/new' do
    before { sign_in user }

    it 'responds with HTTP status success(200)' do
      get new_quiz_path

      expect(response).to have_http_status(200)
    end

    it 'renders new template with form partial' do
      get new_quiz_path

      expect(response).to render_template('new')
      expect(response).to render_template(partial: '_form')
    end
  end
end
