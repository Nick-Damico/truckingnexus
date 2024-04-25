# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerSheetsHelper, type: :helper do
  let(:user_quiz) { create(:user_quiz) }
  let(:answer_sheet) { user_quiz.answer_sheet }

  describe '#correct_answer_count' do
    it 'returns the number of correct answers' do
      answer_sheet = user_quiz.answer_sheet
      questions = answer_sheet.questions
      correct_answer = questions.first.answers.where(correct: true).first

      answer_sheet.answer_sheet_questions.first.update(answer: correct_answer)

      expect(correct_answer_count(answer_sheet)).to eq 1
    end
  end

  describe '#incorrect_answer_count' do
    it 'returns the number of incorrect answers' do
      answer_sheet = user_quiz.answer_sheet
      question = answer_sheet.answer_sheet_questions.first.question
      incorrect_answer = Answer.where(question:, correct: false).first

      answer_sheet.answer_sheet_questions.first.update(answer: incorrect_answer)

      expect(incorrect_answer_count(answer_sheet)).to eq 1
    end
  end

  describe '#total_question_count' do
    it 'returns total question count for the quiz' do
      expected_count = answer_sheet.answer_sheet_questions.count

      expect(total_question_count(answer_sheet)).to eq expected_count
    end
  end
end
