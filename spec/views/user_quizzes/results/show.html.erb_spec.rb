# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user_quizzes/results/show', type: :view do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'GET /show' do
    it 'displays the score' do
      user_quiz = create(:user_quiz, :with_completed_quiz, :with_graded_quiz, user:)
      assign(:user_quiz, user_quiz)

      render

      expect(render).to match("#{user_quiz.score}%")
    end

    context 'Quiz Passed' do
      it "displays a 'Passed' message" do
        assign(:user_quiz, create(:user_quiz, :with_completed_quiz, :with_graded_quiz, user:))
        render

        expect(render).to match(/#{UserQuizzes::ResultsHelper::PASSED_MESSAGE}/i)
      end
    end

    context 'Quiz Failed' do
      it "displays a 'Failed' message" do
        assign(:user_quiz, create(:user_quiz, :with_failed_quiz, :with_graded_quiz, user:))
        render

        expect(render).to match(/#{UserQuizzes::ResultsHelper::FAILED_MESSAGE}/i)
      end
    end
  end
end
