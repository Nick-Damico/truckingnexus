# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerSheet, type: :model do
  let!(:user_quiz) do
    user_quiz = create(:user_quiz, quiz: create(:quiz, :with_questions))
    user_quiz.prep_for_quiz # Generate the assoc. AnswerSheet for use in subject assignment.
    user_quiz
  end
  subject { user_quiz.answer_sheet }

  it { should belong_to(:user_quiz) }
  it { should have_many(:answer_sheet_questions) }
  it { should have_many(:questions).through(:answer_sheet_questions) }
  it { should have_many(:answers).through(:answer_sheet_questions) }

  describe '.prep_for_quiz' do
    it 'generates AnswerSheet for UserQuiz' do
      user_quiz = create(:user_quiz, quiz: create(:quiz, :with_questions))
      expect do
        AnswerSheet.prep_for_quiz(user_quiz:)
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
      unanswered_question = subject.next_question

      expect(unanswered_question).to be_a(AnswerSheetQuestion)
    end
  end

  describe '#unanswered_question_count' do
    it 'returns a integer count for the remaining unanswered questions' do
      expected_count = subject.answer_sheet_questions.unanswered_questions.count
      expect(subject.unanswered_question_count).to be_a(Integer)
      expect(subject.unanswered_question_count).to_not be_nil
      expect(subject.unanswered_question_count).to eq expected_count
    end
  end

  describe '#completed?' do
    it 'returns true if all questions are completed' do
      subject.answer_sheet_questions.each do |as_question|
        user_answer = as_question.question.answers.first
        as_question.update(answer: user_answer)
      end

      expect(subject.completed?).to eq true
    end

    it 'returns false if unanswered questions remain' do
      subject.answer_sheet_questions.each { |question| question.update(answer_id: nil) }

      expect(subject.completed?).to eq false
    end
  end
end
