# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuizzesHelper, type: :helper do
  describe '#quiz_submit_btn_text' do
    context 'unpersisted' do
      it "returns a string of 'Save Draft' for new records" do
        quiz = build(:quiz)

        expect(quiz_submit_btn_text(quiz)).to eq('Save Draft')
      end
    end

    context 'persisted' do
      it "returns a string of 'Save Draft' for new records" do
        quiz = create(:quiz)

        expect(quiz_submit_btn_text(quiz)).to eq('Update Quiz')
      end
    end
  end
end
