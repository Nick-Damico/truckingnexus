# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'driver_logs/new', type: :view do
  let(:user) { create(:user) }

  context 'new log' do
    before do
      assign(:driver_log, user.driver_logs.build)

      render
    end

    it 'displays a new driver log heading' do
      expect(rendered).to have_selector('h2', text: 'New Drivers Daily Log')
    end

    # EXPECTED TEXT FIELDS
    {
      employee_number: 'Employee number',
      first_name: 'First name',
      last_name: 'Last name',
      tractor_number: 'Tractor number',
      trailer_number_1: 'Trailer number 1',
      trailer_number_2: 'Trailer number 2'
    }.each do |_field, label|
      it "displays input field for #{label}" do
        expect(rendered).to have_field(label)
      end
    end
  end
end
