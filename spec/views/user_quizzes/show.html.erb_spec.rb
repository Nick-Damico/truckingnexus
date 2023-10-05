# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user_quizzes/show', type: :view do
  let(:user_quiz) { create(:user_quiz, quiz: create(:quiz, :with_questions)) }

  it 'renders a quiz' do; end
end
