# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerSheet, type: :model do
  let!(:quiz) { create(:quiz, :with_questions) }
  let!(:user_quiz) { create(:user_quiz, quiz:) }

  it { should belong_to(:user_quiz) }
  it { should have_many(:answer_sheet_questions) }
  it { should have_many(:questions).through(:answer_sheet_questions) }
  it { should have_many(:answers).through(:answer_sheet_questions) }

  describe '.prep_for_quiz' do
    it 'generates AnswerSheet for UserQuiz' do
      expect do
        described_class.prep_for_quiz(user_quiz:)
      end.to change(AnswerSheet, :count).by(1)
    end

    it 'generates AnswerSheetQuestion records for a quizzes questions' do
      expected_count = user_quiz.quiz.questions.count
      expect(expected_count).to_not be_nil
      expect(expected_count).to_not be_zero
      expect do
        described_class.prep_for_quiz(user_quiz:)
      end.to change(AnswerSheetQuestion, :count).by(expected_count)
    end
  end

  describe '#next_question' do
    it 'returns the next unanswered AnswerSheetQuestion' do
      user_quiz.prep_for_quiz
      answer_sheet = user_quiz.answer_sheet
      unanswered_question = answer_sheet.next_question

      expect(unanswered_question).to be_a(AnswerSheetQuestion)
    end
  end
end
