# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/users', type: :request do
  let(:auth_user) { create(:user, :admin) }
  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.

  let(:invalid_attributes) do
    {
      admin: nil,
      email: nil,
      password: ''
    }
  end

  before do
    sign_in auth_user
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create(:user)
      get users_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = create(:user)
      get user_url(user)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      user = create(:user)
      get edit_user_url(user)
      expect(response).to be_successful
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          admin: true
        }
      end

      it 'updates the requested user' do
        user = create(:user)
        patch user_url(user), params: { user: new_attributes }
        user.reload
        expect(user.admin).to be_truthy
      end

      it 'redirects to the user' do
        user = create(:user)
        patch user_url(user), params: { user: new_attributes }
        user.reload
        expect(response).to redirect_to(user_url(user))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested user' do
      user = create(:user)
      expect do
        delete user_url(user)
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      user = create(:user)
      delete user_url(user)
      expect(response).to redirect_to(users_url)
    end
  end
end
