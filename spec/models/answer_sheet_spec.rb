# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerSheet, type: :model do
  it { should belong_to(:user_quiz) }
  it { should have_many(:answer_sheet_questions) }
  it { should have_many(:questions).through(:answer_sheet_questions) }
  it { should have_many(:answers).through(:answer_sheet_questions) }
end
