# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DriverLogs', type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'GET /driver_logs' do
    it 'return status code 200' do
      get driver_logs_path
      expect(response).to have_http_status(200)
    end

    it 'renders the index view template' do
      get driver_logs_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /driver_logs/new' do
    it 'return status code 200' do
      get new_driver_log_path
      expect(response).to have_http_status(200)
    end

    it 'renders the index view template' do
      get new_driver_log_path
      expect(response).to render_template(:new)
    end
  end
end
