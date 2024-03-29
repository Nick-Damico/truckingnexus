# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerSheetQuestion, type: :model do
  let(:answer_sheet) { create(:answer_sheet) }
  let(:answer_sheet_question) { answer_sheet.answer_sheet_questions.create(question: create(:question)) }

  it { should belong_to(:answer).optional(true) }
  it { should belong_to(:question) }
  it { should belong_to(:answer_sheet) }

  it { should have_db_index(%i[id question_id]).unique }
end
