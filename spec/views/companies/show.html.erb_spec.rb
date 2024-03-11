# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'companies/show', type: :view do
  let(:user) { create(:user) }
  subject { create(:company) }

  before do
    assign(:company, subject)
    assign(:rating, subject.rating)
    assign(:review_count, subject.reviews.count)
  end

  it 'displays a Company name' do
    render

    expect(rendered).to have_content(subject.name)
  end

  context 'authenticated user' do
    before { sign_in user }

    describe 'user has not reviewed' do
      it "displays 'create review' link" do
        render

        expect(rendered).to have_link 'Review', href: new_company_review_path(subject)
      end
    end

    describe 'user reviewed' do
      before { subject.reviews << create(:review, reviewer: user) }

      it "does not display 'create review' link" do
        render

        expect(rendered).to_not have_link 'Review', href: new_company_review_path(subject)
      end
    end
  end

  context 'unauthenticated user' do
    before { sign_out user }

    it "does not display 'create review' button" do
      render

      expect(rendered).to_not have_link 'Review', href: new_company_review_path(subject)
    end
  end

  context 'without review' do
    it 'displays review count of zero' do
      render

      expect(rendered).to have_content('0 Reviews')
    end
  end
end
