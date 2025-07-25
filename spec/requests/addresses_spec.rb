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

RSpec.describe '/addresses', type: :request do
  let(:user) { create(:user, admin: true) }
  # This should return the minimal set of attributes required to create a valid
  # Address. As you add validations to Address, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      address: '123 Main St'
    }
  end

  let(:invalid_attributes) do
    {
      address: nil
    }
  end

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Address.create! valid_attributes
      get addresses_url
      expect(response).to be_successful
    end

    it 'rejects non-admin users' do
      user.update(admin: false)
      get addresses_url
      expect(response).not_to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      address = Address.create! valid_attributes
      get address_url(address)
      expect(response).to be_successful
    end

    it 'rejects non-admin users' do
      user.update(admin: false)
      address = Address.create! valid_attributes
      get address_url(address)
      expect(response).not_to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_address_url
      expect(response).to be_successful
    end

    it 'rejects non-admin users' do
      user.update(admin: false)
      get new_address_url
      expect(response).not_to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      address = Address.create! valid_attributes
      get edit_address_url(address)
      expect(response).to be_successful
    end

    it 'rejects non-admin users' do
      user.update(admin: false)
      address = Address.create! valid_attributes
      get edit_address_url(address)
      expect(response).not_to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Address' do
        expect do
          post addresses_url, params: { address: valid_attributes }
        end.to change(Address, :count).by(1)
      end

      it 'redirects to the created address' do
        post addresses_url, params: { address: valid_attributes }
        expect(response).to redirect_to(address_url(Address.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Address' do
        expect do
          post addresses_url, params: { address: invalid_attributes }
        end.not_to change(Address, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post addresses_url, params: { address: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    it 'rejects non-admin users' do
      user.update(admin: false)
      post addresses_url, params: { address: valid_attributes }
      expect(response).not_to be_successful
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          address: '456 Elm St'
        }
      end

      it 'updates the requested address' do
        address = Address.create! valid_attributes
        patch address_url(address), params: { address: new_attributes }
        address.reload
        expect(address.address).to eq('456 Elm St')
      end

      it 'redirects to the address' do
        address = Address.create! valid_attributes
        patch address_url(address), params: { address: new_attributes }
        address.reload
        expect(response).to redirect_to(address_url(address))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        address = Address.create! valid_attributes
        patch address_url(address), params: { address: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    it 'rejects non-admin users' do
      user.update(admin: false)
      address = Address.create! valid_attributes
      patch address_url(address), params: { address: valid_attributes }
      expect(response).not_to be_successful
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested address' do
      address = Address.create! valid_attributes
      expect do
        delete address_url(address)
      end.to change(Address, :count).by(-1)
    end

    it 'redirects to the addresses list' do
      address = Address.create! valid_attributes
      delete address_url(address)
      expect(response).to redirect_to(addresses_url)
    end

    it 'rejects non-admin users' do
      user.update(admin: false)
      address = Address.create! valid_attributes
      delete address_url(address)
      expect(response).not_to be_successful
    end
  end
end
