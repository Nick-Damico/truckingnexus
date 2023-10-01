# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerSheetQuestion, type: :model do
  it { should belong_to(:answer) }
  it { should belong_to(:question) }
  it { should belong_to(:answer_sheet) }
end
