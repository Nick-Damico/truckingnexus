# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :view do
  let(:user) { create(:user, :with_current_employer, username: 'Sam Puppies') }

  before do
    assign(:user, user)
  end

  context "page_content is 'profile" do
    before do
      params[:page_content] = 'profile'
      assign(:page_content, params[:page_content])
      assign(:companies, Company.order(:name))
      assign(:employment_history, EmploymentHistory.new(current: true))
      assign(:current_employer, user.current_employer)
    end

    context 'section: User Information' do
      it 'displays the User Information heading' do
        render

        expect(rendered).to have_content('User Information')
      end

      it 'displays the username in a text input field' do
        render

        expect(rendered).to have_field('Username', with: user.username)
      end
    end
  end
end
