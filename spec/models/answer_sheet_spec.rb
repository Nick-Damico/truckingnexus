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
    it 'adds an AnswerSheet to the UserQuiz' do
      expect do
        create(:user_quiz)
      end.to change(AnswerSheet, :count).by(1)
    end

    it 'adds AnswerSheetQuestion records to AnswerSheet' do
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
    it 'returns a count for unanswered questions' do
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

  describe '#number_of_questions' do
    it 'returns the total number of questions on quiz' do
      expected_count = subject.questions.count
      expect(subject.number_of_questions).to eq expected_count
    end
  end

  describe '#correct_questions' do
    it 'returns collection of AnswerSheetQuestions answered correctly' do
      answer_sheet_question = subject.answer_sheet_questions.first
      correct_answer = answer_sheet_question.question.correct_answer
      answer_sheet_question.update(answer: correct_answer)

      expect(subject.correct_questions).to eq [answer_sheet_question]
    end
  end

  describe '#incorrect_questions' do
    it 'returns collection of AnswerSheetQuestions missed' do
      answer_sheet_question = subject.answer_sheet_questions.first
      incorrect_answer = Answer.joins(:question).where(question: answer_sheet_question.question, correct: false).first

      answer_sheet_question.update(answer: incorrect_answer)

      expect(subject.incorrect_questions).to eq [answer_sheet_question]
    end
  end

  describe '#correct_answer_count' do
    it 'returns the total number of questions answered correctly' do
      answer_sheet_question = subject.answer_sheet_questions.first
      correct_answer = answer_sheet_question.question.correct_answer
      answer_sheet_question.update(answer: correct_answer)

      expect(subject.correct_answer_count).to eq 1
    end
  end

  describe '#incorrect_answer_count' do
    it 'returns a count of question answered incorrectly' do
      answer_sheet_question = subject.answer_sheet_questions.first
      incorrect_answer = Answer.joins(:question).where(question: answer_sheet_question.question, correct: false).first

      answer_sheet_question.update(answer: incorrect_answer)

      expect(subject.incorrect_answer_count).to eq 1
    end
  end
end
