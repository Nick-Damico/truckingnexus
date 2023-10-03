# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuizService::Grader do
  let!(:user_quiz) { create(:user_quiz, quiz: create(:quiz, :with_questions)) }

  context 'Completed Quiz' do
    describe '#call' do
      it 'calculates the compeleted quizzes resulting grade' do
        compelete_quiz(user_quiz)
        QuizService::Grader.new(user_quiz:).call

        expect(user_quiz.score).to_not be_nil
        expect(user_quiz.score).to eq 100
      end
    end
  end

  def compelete_quiz(user_quiz)
    user_quiz.prep_for_quiz
    user_quiz.answer_sheet.answer_sheet_questions.each do |as_question|
      correct_answer = as_question.question.correct_answer
      as_question.update(answer: correct_answer)
    end
  end
end
