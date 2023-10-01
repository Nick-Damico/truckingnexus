# frozen_string_literal: true

class AnswerSheetQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :answer
  belongs_to :answer_sheet
end
