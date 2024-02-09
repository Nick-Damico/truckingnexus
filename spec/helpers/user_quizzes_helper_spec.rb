# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserQuizzesHelper, type: :helper do
  describe '#user_quiz_button' do
    it 'returns empty string if user_quiz or user are nil' do
      user = create(:user)
      user_quiz = nil

      expect(user_quiz_button(user_quiz:, user:)).to eq ''
    end

    context 'Active UserQuiz' do
      it "returns button with text 'resume'" do
        user = create(:user)
        user_quiz = create(:user_quiz, user:)

        expect(user_quiz_button(user_quiz:, user:)).to match(/resume/i)
      end

      # Helper provides Two options:
      # Button with text Yes to resume
      # Button with text No to destroy in-progress quiz
      it 'returns button with link to resume quiz' do
        user = create(:user)
        user_quiz = create(:user_quiz, user:)

        expected_href = user_quiz_path(user_quiz)

        expect(user_quiz_button(user_quiz:, user:)).to match(/Yes/)
        expect(user_quiz_button(user_quiz:, user:)).to match(/#{expected_href}/)
      end

      it 'returns button to destroy incomplete quiz' do
        user = create(:user)
        user_quiz = create(:user_quiz, user:)

        expected_href = user_quiz_path(user_quiz)

        expect(user_quiz_button(user_quiz:, user:)).to match(/No/)
        expect(user_quiz_button(user_quiz:, user:)).to match(/action="#{expected_href}"/)
        expect(user_quiz_button(user_quiz:, user:)).to match(/method="post"/i)
        expect(user_quiz_button(user_quiz:, user:)).to match(/value="delete"/i)
      end
    end

    context 'Completed Quiz' do
      it 'returns a link to review the results' do
        user = create(:user)
        user_quiz = create(:user_quiz, :with_completed_quiz, :with_graded_quiz)

        expected_href = user_quizzes_result_path(user_quiz)

        expect(user_quiz_button(user_quiz:, user:)).to match(/results/i)
        expect(user_quiz_button(user_quiz:, user:)).to match(/#{expected_href}/)
      end
    end
  end
end
