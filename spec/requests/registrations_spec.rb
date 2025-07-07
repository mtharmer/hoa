# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'GET /auth/sign_up' do
    it 'returns http success' do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /auth' do
    let(:valid_attributes) do
      {
        user: {
          email: 'some@email.com',
          password: 'GoodPassword123',
          password_confirmation: 'GoodPassword123',
          name: 'Test User',
          address_id: create(:address).id
        }
      }
    end

    it 'creates a new user and redirects to the root path' do
      post user_registration_path, params: valid_attributes
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(flash[:notice]).to include(
        'You have signed up successfully. You must wait for an admin to approve your account before you can log in.'
      )
    end

    it 'does not allow login after sign-up' do
      post user_registration_path, params: valid_attributes
      follow_redirect!
      expect(flash[:notice]).to include(
        'You have signed up successfully. You must wait for an admin to approve your account before you can log in.'
      )
      expect(session[:user_id]).to be_nil
    end
  end
end
