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

    # page_content: :profile returns partial '_profile' containing the users/_form
    context 'GET /profile' do
      it 'returns http success' do
        get user_path(user, page_content: :profile)
        expect(response).to have_http_status(:success)
      end
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

    context 'employment_histories_attributes' do
      it 'sets the users current employer' do
        @current_employer = create(:company)
        params[:user].merge!(employment_history_params(@current_employer, current: true))

        patch(user_path(user), params:)

        expect(user.reload.current_employer).to eq(@current_employer)
      end

      context 'params blank' do
        it 'does not update users current employer' do
          employer = double('employer')
          expect(employer).to receive(:id).and_return(nil)
          params[:user].merge!(employment_history_params(employer, current: true))

          expect(EmploymentHistoryManager).to_not receive(:new)
          patch(user_path(user), params:)

          expect(user.reload.current_employer).to be_nil
        end
      end
    end
  end

  private

  def employment_history_params(employer, current: false)
    { 'employment_histories_attributes' =>
      { '0' => { 'current' => current.to_s, 'employer_id' => employer.id.to_s } } }
  end
end
