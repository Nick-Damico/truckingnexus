# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuizService::Grader do
  include ActiveSupport::Testing::TimeHelpers
  context 'Completed Quiz' do
    describe '#call' do
      it 'calculates the compeleted quizzes resulting grade' do
        user_quiz = create(:user_quiz, :with_graded_quiz)

        expect(user_quiz.score).to_not be_nil
      end

      it 'records the completed_at date' do
        user_quiz = nil
        expected_datetime = DateTime.current
        freeze_time do
          user_quiz = create(:user_quiz, :with_graded_quiz)
        end

        expect(user_quiz.completed_at).to_not be_nil
        expect(user_quiz.completed_at).to eq expected_datetime.to_s
      end
    end
  end
end
