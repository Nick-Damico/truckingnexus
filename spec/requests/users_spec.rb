# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  subject(:user) { create(:user) }

  before { sign_in user }

  describe 'GET /show' do
    it 'returns http success' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    let(:expected_username) { 'Johnny Appleseed' }
    let(:params) { { user: { username: expected_username } } }

    it 'redirects to user show page' do
      patch(user_path(user), params:)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to user
    end

    it 'updates users name' do
      patch(user_path(user), params:)
      expect(user.reload.username).to eq expected_username
      expect(user.reload.username).to_not be_nil
    end

    context 'current employer' do
      before do
        @current_employer = create(:company)
        params[:user].merge!(
          { 'employment_histories_attributes' =>
            { '0' => { 'current' => 'true', 'employer_id' => @current_employer.id } } }
        )

        patch user_path(user), params: params
      end

      it 'sets the users current employer' do
        expect(user.reload.current_employer).to eq(@current_employer)
      end

      xit 'updates the employment history record when the company is changed' do
      end
    end
  end
end
