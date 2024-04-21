# frozen_string_literal: true

RSpec.shared_examples 'Authorized Routes' do
  let(:unauthorized_user) { create(:user) }
  let(:authorized_routes) { [] } # Add routes that should be protected with authorization

  before { sign_in unauthorized_user }

  context 'when trying to access without authorization' do
    it 'responds with HTTP status redirect(302)' do
      authorized_routes.each do |route|
        get route

        expect(response).to have_http_status(:redirect)
        # expect(response).to redirect_to(redirect_route) # Adjust this if your redirection logic differs
      end
    end

    it 'displays a flash message indicating unauthorized access' do
      authorized_routes.each do |route|
        get route

        expect(flash[:alert]).to eq(I18n.t('flash.unauthorized_access')) # Adjust the flash message as per your application
      end
    end
  end
end
