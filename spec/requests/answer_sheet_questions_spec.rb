# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AnswerSheetQuestions', type: :request do
  let(:answer_sheet) do
    user_quiz = create(:user_quiz, quiz: create(:quiz, :with_questions))
    user_quiz.prep_for_quiz
    user_quiz.answer_sheet
  end
  let!(:answer_sheet_question) { answer_sheet.answer_sheet_questions.first }

  let!(:valid_params) do
    correct_answer = answer_sheet_question.question.correct_answer
    {
      answer_sheet_question: {
        answer_id: correct_answer.id
      }
    }
  end

  describe 'PUT /answer_sheet_question' do
    it 'renders the index template' do
      patch answer_sheet_question_path(answer_sheet_question), params: valid_params

      expect(response).to have_http_status(302)
      expect(answer_sheet_question.reload.answer_id).to_not be_nil
    end

    context 'question is submitted without selecting an answer' do
      let!(:invalid_params) { {} }

      it 'redirects back to the question without raising an exception' do
        expect do
          patch answer_sheet_question_path(answer_sheet_question), params: invalid_params
        end.to_not raise_error

        expect(response).to have_http_status(302)
      end

      it 'displays an flash error message' do
        expect do
          patch answer_sheet_question_path(answer_sheet_question), params: invalid_params
        end.to_not raise_error

        expect(flash[:alert]).to eq('Oops! Please choose an answer before submitting.')
      end
    end
  end
end
