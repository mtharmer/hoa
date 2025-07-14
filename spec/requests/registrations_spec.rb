# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'GET /auth/sign_up' do
    it 'returns http success' do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /auth/profile' do
    let(:user) { create(:user, locked: false) }

    before do
      sign_in user
      get edit_user_registration_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /auth/update_profile' do
    let(:address) { create(:address) }
    let(:new_address) { create(:address) }
    let(:user) { create(:user, :unlocked, address:) }

    let(:valid_attributes) do
      {
        user: {
          email: 'new@email.com',
          name: 'Updated Name',
          address_id: new_address.id
        }
      }
    end

    let(:invalid_attributes) do
      {
        user: {
          email: 'invalid_email',
          name: '',
          address_id: nil
        }
      }
    end

    before do
      sign_in user
    end

    describe 'with valid attributes' do
      it 'updates the user profile and redirects to root path' do
        put profile_path(user), params: valid_attributes
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(flash[:notice]).to eq('Your account has been updated successfully.')
      end

      it 'changes the email' do
        put profile_path(user), params: valid_attributes
        user.reload
        expect(user.email).to eq('new@email.com')
      end

      it 'changes the name' do
        put profile_path(user), params: valid_attributes
        user.reload
        expect(user.name).to eq('Updated Name')
      end

      it 'changes the address' do
        put profile_path(user), params: valid_attributes
        user.reload
        expect(user.address).to eq(new_address)
      end
    end

    describe 'with invalid attributes' do
      it 'does not update the user profile' do
        put profile_path(user), params: invalid_attributes
        expect(flash[:alert]).to eq('There was an error updating your account. Please try again.')
      end

      it 'does not change the email' do
        original_email = user.email
        put profile_path(user), params: invalid_attributes
        user.reload
        expect(user.email).to eq(original_email)
      end
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
