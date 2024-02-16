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

  context 'without review' do
    it 'displays a no reviews message' do
      assign(:company, subject)

      render

      expect(rendered).to match(/no one has left a review yet/i)
      expect(rendered).to have_content('0 Reviews')
    end
  end

  context 'with review' do
    before do
      subject.reviews << create_list(:review, 1)
      assign(:company, subject)

      render
    end

    it 'displays reviewer count' do
      expected_content = "#{subject.reviews.count} #{'Review'.pluralize(subject.reviews.count)}"
      expect(rendered).to have_content(expected_content)
    end

    it 'displays review username' do
      expect(rendered).to have_content(subject.reviews.first.reviewer.username)
    end

    it 'displays review title' do
      expect(rendered).to have_content(subject.reviews.first.title)
    end

    it 'displays reviewers rating' do
      expect(rendered).to have_content(subject.reviews.first.rating.to_f)
    end

    it 'displays review content' do
      expect(rendered).to have_content(subject.reviews.first.content)
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
