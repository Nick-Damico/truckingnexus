# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  let!(:question) { create(:question) }
  subject { build(:answer, question:) }

  it { should belong_to(:question) }
  it { should validate_presence_of(:content) }
  it {
    should validate_uniqueness_of(:content).scoped_to(:question_id).case_insensitive.with_message('answer has already been taken')
  }
end
