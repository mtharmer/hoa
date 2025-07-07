# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user, password: 'GoodPassword123', locked: false) }

  describe 'GET /users/sign_in' do
    it 'returns http success' do
      get new_user_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /users/sign_in' do
    it 'logs in the user with valid credentials' do
      post user_session_path, params: { user: { email: user.email, password: 'GoodPassword123' } }
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('Signed in successfully.')
    end

    it 'fails to log in with invalid credentials' do
      post user_session_path, params: { user: { email: user.email, password: 'wrongpassword' } }
      expect(response.body).to include('Invalid Email or password.')
    end

    it 'fails to log in with locked account' do
      user.update(locked: true)
      post user_session_path, params: { user: { email: user.email, password: 'GoodPassword123' } }
      expect(flash[:alert]).to include('Your account is locked. Please contact an administrator to unlock it.')
    end
  end

  describe 'DELETE /users/sign_out' do
    before do
      sign_in create(:user)
    end

    it 'logs out the user' do
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('Signed out successfully.')
    end
  end
end
