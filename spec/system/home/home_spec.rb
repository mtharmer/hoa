# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the main page', type: :system do
  before do
    visit root_path
  end

  it 'shows the welcome message' do
    expect(page).to have_content('Home#index')
  end

  describe 'when not signed in' do
    it 'has a link to sign up' do
      expect(page).to have_link('Sign Up', href: new_user_registration_path)
    end

    it 'has a link to sign in' do
      expect(page).to have_link('Login', href: new_user_session_path)
    end

    it 'has a link to the home page' do
      expect(page).to have_link('HOA Home', href: root_path)
    end
  end

  describe 'when signed in' do
    let(:address) { create(:address) }
    let(:user) { create(:user, locked: false, address:) }

    before do
      sign_in user
      visit root_path
    end

    it 'shows the user address' do
      expect(page).to have_content(user.address.address.to_s)
    end

    it 'has a link to the posts page' do
      expect(page).to have_link('Dashboard', href: posts_path)
    end

    it 'has a link to edit the user profile' do
      expect(page).to have_link('Edit Profile', href: edit_user_registration_path)
    end

    it 'has a link to sign out' do
      expect(page).to have_button('Logout')
    end
  end

  describe 'when signed in as an admin' do
    let(:address) { create(:address) }
    let(:admin) { create(:user, locked: false, admin: true, address:) }

    before do
      sign_in admin
      visit root_path
    end

    it 'shows the user address' do
      expect(page).to have_content(admin.address.address.to_s)
    end

    it 'has a link to the posts page' do
      expect(page).to have_link('Dashboard', href: posts_path)
    end

    it 'has a link to edit the user profile' do
      expect(page).to have_link('Edit Profile', href: edit_user_registration_path)
    end

    it 'has a link to sign out' do
      expect(page).to have_button('Logout')
    end

    it 'has a link to the documents page' do
      expect(page).to have_link('Documents', href: documents_path)
    end

    it 'has a link to the addresses page' do
      expect(page).to have_link('Addresses', href: addresses_path)
    end

    it 'has a link to manage users' do
      expect(page).to have_link('Users', href: users_path)
    end
  end
end
