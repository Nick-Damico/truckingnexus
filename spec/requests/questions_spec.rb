# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  let(:quiz) { create(:quiz, :with_questions) }

  # it_behaves_like 'Authenticated Route' do
  #   let(:authenticated_routes) { [new_question_path] }
  # end

  describe 'GET quzzies/:quiz_id/questions' do
    it 'responds with HTTP status success(200)' do
      get quiz_questions_path(quiz)

      expect(response).to have_http_status(:success)
    end
  end

end
