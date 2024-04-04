# frozen_string_literal: true

RSpec.shared_examples 'Authenticated Route' do
  let(:authenticated_routes) { [] } # Add routes that should be protected with authorization

  context 'authentication' do
    describe 'prevents unauthenticated user access' do
      it 'returns HTTP status redirect(302)' do
        authenticated_routes.each do |route|
          get route

          expect(response).to have_http_status(:redirect)
        end
      end

      it 'redirects to sign in form' do
        authenticated_routes.each do |route|
          get route

          expect(response).to redirect_to(user_session_url)
        end
      end
    end
  end
end
