# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :view do
  let(:user) { create(:user, :with_current_employer, username: 'Sam Puppies') }

  before do
    assign(:user, user)
  end

  context "page_content is 'driver_log'" do
    before do
      params[:page_content] = 'driver_logs'
      assign(:page_content, params[:page_content])

      # assign(:companies, Company.order(:name))
      # assign(:employment_history, EmploymentHistory.new(current: true))
      # assign(:current_employer, user.current_employer)
    end

    context "section: Driver's Logs" do
      it "display intro section heading 'Driver's Logs'" do
        render

        expect(rendered).to have_content("Driver's Logs")
      end
    end

    context 'section: Record of Duty Status Logs' do
      it "displays intro section heading 'Record of Duty Status Logs'" do
        render

        expect(rendered).to have_content('Record of Duty Status Logs')
      end

      it 'displays link to new driver log form' do
        render

        expect(rendered).to have_link('New Driver Log', href: new_driver_log_path)
      end
    end
  end
end
