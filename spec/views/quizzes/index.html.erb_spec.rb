# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quizzes/index', type: :view do
  let!(:user) { create(:user) }
  let!(:quizzes) { create_list(:quiz, 1, :with_questions) }

  before do
    sign_in user
    render
    render partial: 'quiz_card', collection: quizzes, as: 'quiz'
  end

  xit 'renders a list of quizzes' do
    expect(rendered).to include('CDL Quizzes')
    expect(rendered).to include(quizzes.first.name)
  end

  xcontext 'User has no Active quiz' do
    it 'should display a start button' do
      expect(rendered).to include('Start')
    end
  end

  xcontext 'User has an incomplete Active quiz' do
    it 'User should have the choice to Resume active quiz' do
      create(:user_quiz, quiz: quizzes.first, user:)
      user.reload
      render
      render partial: 'quiz_card', collection: quizzes, as: 'quiz'

      expect(rendered).to include('Resume Quiz?')
    end
  end
end
