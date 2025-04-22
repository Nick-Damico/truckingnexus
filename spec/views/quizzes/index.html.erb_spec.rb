# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quizzes/index', type: :view do
  let!(:user) { create(:user) }
  let!(:quiz) { create(:quiz, :with_questions, :published, name: "Ruby Basics") }

  before do
    sign_in user
    render
    render partial: 'quiz_card', collection: [ quiz ], as: 'quiz'
  end

  it 'renders a list of quizzes' do
    expect(rendered).to include("Ruby Basics")
  end

  it "shows a Start button inside a quiz-card" do
    dom = Capybara.string(rendered)
    expect(dom).to have_selector(".quiz-card button", text: "Start Quiz")
  end
end
