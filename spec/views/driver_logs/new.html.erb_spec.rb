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
      expect(rendered).to have_selector('h2', text: 'New Driver Log')
    end
  end
end
