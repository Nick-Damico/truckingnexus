# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ApplicationController', model: :request do
  let(:password) { Faker::Internet.password(min_length: 6) }
  let(:user) { create(:user, password:) }

  context 'sign in' do
    describe 'success' do
      it 'redirects to users dashboard' do
        params = { user: { email: user.email, password: } }

        post(user_session_path, params:)

        expect(response).to redirect_to(user)
      end
    end

    describe 'failure' do
      it 're-renders sign_in form with error message' do
        params = { user: { email: user.email, password: Faker::Internet.password } }

        post(user_session_path, params:)

        expect(response).to render_template('sessions/new')
        expect(flash[:alert]).to eq 'Invalid Email or password.'
      end
    end
  end
end
