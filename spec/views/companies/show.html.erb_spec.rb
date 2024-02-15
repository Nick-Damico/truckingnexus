# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'companies/show', type: :view do
  let(:user) { create(:user) }
  subject { create(:company) }

  before { sign_in user }

  it 'displays a Company name' do
    assign(:company, subject)

    render

    expect(rendered).to have_content(subject.name)
  end

  it 'displays link to create a review' do
    assign(:company, subject)

    render

    expect(rendered).to have_link 'Review', href: new_company_review_path(subject)
  end

  context 'review' do
    let(:company) { create(:company, :with_reviews) }
    before do
      assign(:company, company)

      render
    end

    it 'displays reviewer count' do
      expected_content = "#{company.reviews.count} #{'Review'.pluralize(company.reviews.count)}"
      expect(rendered).to have_content(expected_content)
    end

    it 'displays reviewers username' do
      expect(rendered).to have_content(company.reviews.first.reviewer.username)
    end

    it 'displays review title' do
      expect(rendered).to have_content(company.reviews.first.title)
    end

    it 'displays reviewers rating' do
      expect(rendered).to have_content(company.reviews.first.rating.to_f)
    end

    it 'displays review content' do
      expect(rendered).to have_content(company.reviews.first.content)
    end
  end

  # xdescribe 'GET /show' do
  #   it 'displays the score' do
  #     user_quiz = create(:user_quiz, :with_completed_quiz, :with_graded_quiz, user:)
  #     assign(:user_quiz, user_quiz)

  #     render

  #     expect(render).to match("#{user_quiz.score}%")
  #   end

  #   context 'Quiz Passed' do
  #     it "displays a 'Passed' message" do
  #       assign(:user_quiz, create(:user_quiz, :with_completed_quiz, :with_graded_quiz, user:))
  #       render

  #       expect(render).to match(/#{UserQuizzes::ResultsHelper::PASSED_MESSAGE}/i)
  #     end
  #   end

  #   context 'Quiz Failed' do
  #     it "displays a 'Failed' message" do
  #       assign(:user_quiz, create(:user_quiz, :with_failed_quiz, :with_graded_quiz, user:))
  #       render

  #       expect(render).to match(/#{UserQuizzes::ResultsHelper::FAILED_MESSAGE}/i)
  #     end
  #   end
  # end
end
