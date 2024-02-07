# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserQuizzes::ResultsHelper, type: :helper do
  describe '#result_msg' do
    context 'user passed quiz' do
      it 'returns content notifying user' do
        user_quiz = create(:user_quiz, :with_completed_quiz, :with_graded_quiz)

        expect(result_msg(user_quiz)).to match(/#{described_class::PASSED_MESSAGE}/i)
      end
    end

    context 'user failed quiz' do
      it 'returns content notifying user' do
        user_quiz = create(:user_quiz, :with_failed_quiz, :with_graded_quiz)

        expect(result_msg(user_quiz)).to match(/#{described_class::FAILED_MESSAGE}/i)
      end
    end
  end
end
