# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Requests', type: :request do
  subject { create(:user, username: 'Paul Bunyan') }
  let(:avatar) do
    fixture_file_upload(
      Rails.root.join('spec', 'fixtures', 'default-avatar01.png'),
      'image/png'
    )
  end

  it_behaves_like 'Authorized Routes' do
    let(:authorized_routes) { [ user_path(subject) ] }
  end

  before { sign_in subject }

  context 'authentication' do
    describe 'prevents unauthenticated user access' do
      it 'returns HTTP status redirect(302)' do
        sign_out subject
        get user_path(subject)
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to sign in form' do
        sign_out subject
        get user_path(subject)

        expect(response).to redirect_to(user_session_url)
      end
    end
  end

  describe 'GET /show' do
    it 'returns HTTP status success(200)' do
      get user_path(subject)
      expect(response).to have_http_status(:success)
    end

    # page_content: :profile returns partial '_profile' containing the users/_form
    context 'profile page' do
      it 'returns HTTP status success(200)' do
        get user_path(subject, page_content: :profile)
        expect(response).to have_http_status(:success)
      end
    end

    context 'driver logs' do
      it 'returns HTTP status success(200)' do
        get user_path(subject, page_content: :driver_logs)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PATCH /update' do
    let(:expected_username) { 'Johnny Appleseed' }
    let(:params) { { user: { username: expected_username } } }
    let(:avatar) do
      fixture_file_upload(
        Rails.root.join('spec', 'fixtures', 'default-avatar01.png'),
        'image/png'
      )
    end

    context 'invalid params' do
      let(:user2) { create(:user) }
      let(:invalid_params) { { user: { username: subject.username } } }

      it 'does not persist changes' do
        org_username = user2.username

        patch user_path(user2), params: invalid_params

        expect(user2.reload.username).to eq org_username
      end

      it 'renders the form with flash error message' do
        sign_in user2

        patch user_path(user2), params: invalid_params

        expect(response).to render_template(:edit)
        expect(flash[:alert]).to include(/Username has already been taken/)
      end
    end

    it 'redirects to user show page' do
      patch(user_path(subject), params:)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to subject
    end

    it 'attaches an Avatar image' do
      params[:user].merge!(avatar:)
      patch(user_path(subject), params:)

      expect(response).to redirect_to subject
      expect(subject.reload.avatar).to be_attached
    end

    it 'updates username' do
      patch(user_path(subject), params:)
      expect(subject.reload.username).to eq expected_username
      expect(subject.reload.username).to_not be_nil
    end

    context 'employment_histories_attributes' do
      it 'sets the users current employer' do
        @current_employer = create(:company)
        params[:user].merge!(employment_history_params(@current_employer, current: true))

        patch(user_path(subject), params:)

        expect(subject.reload.current_employer).to eq(@current_employer)
      end

      it "allows the user to change their current employer" do
        subject.employment_histories.create(employer: create(:company), current: true)

        new_employer = create(:company)
        params[:user].merge!(employment_history_params(new_employer, current: true))

        patch(user_path(subject), params:)

        expect(subject.reload.current_employer).to eq(new_employer)
        expect(subject.employment_histories.where(current: true).count).to eq(1)
      end

      context 'params blank' do
        it 'does not update users current employer' do
          employer = double('employer')
          expect(employer).to receive(:id).and_return(nil)
          params[:user].merge!(employment_history_params(employer, current: true))

          expect(EmploymentHistoryManager).to_not receive(:new)
          patch(user_path(subject), params:)

          expect(subject.reload.current_employer).to be_nil
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
