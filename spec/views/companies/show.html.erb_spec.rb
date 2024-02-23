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

  context 'authenticated user' do
    it "displays link to 'create review' button" do
      assign(:company, subject)

      render

      expect(rendered).to have_link 'Review', href: new_company_review_path(subject)
    end
  end

  context 'unauthenticated user' do
    before { sign_out user }

    it "does not display 'create review' button" do
      assign(:company, subject)

      render

      expect(rendered).to_not have_link 'Review', href: new_company_review_path(subject)
    end
  end

  context 'without review' do
    it 'displays review count of zero' do
      assign(:company, subject)

      render

      expect(rendered).to have_content('0 Reviews')
    end
  end
end
