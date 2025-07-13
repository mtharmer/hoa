# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the signup process', type: :system do
  describe 'with valid credentials' do
    let(:user) { build(:user) }

    it 'signs me up' do
      visit new_user_registration_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_button 'Sign up'
      expect(page).to have_content(
        'You have signed up successfully. You must wait for an admin to approve your account before you can log in.'
      )
    end

    it 'creates a locked user' do
      visit new_user_registration_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_button 'Sign up'
      expect(page).to have_content(
        'You have signed up successfully. You must wait for an admin to approve your account before you can log in.'
      )
      expect(User.find_by(email: user.email).locked).to be true
    end

    describe 'with an address' do
      let!(:address) { create(:address) }

      it 'allows an address to be selected' do
        visit new_user_registration_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password confirmation', with: user.password
        select address.address.to_s, from: 'Address'
        click_button 'Sign up'
        expect(page).to have_content(
          'You have signed up successfully. You must wait for an admin to approve your account before you can log in.'
        )
        expect(User.find_by(email: user.email).address).to eq(address)
      end
    end
  end

  describe 'with invalid credentials' do
    let(:user) { build(:user, email: 'invalid_email') }

    it 'does not sign me up' do
      visit new_user_registration_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_button 'Sign up'
      expect(page).to have_no_content(
        'You have signed up successfully. You must wait for an admin to approve your account before you can log in.'
      )
      expect(User.find_by(email: user.email)).to be_nil
    end
  end

  describe 'when the user alreay exists' do
    let(:existing_user) { create(:user) }

    it 'does not sign me up' do
      visit new_user_registration_path
      fill_in 'Email', with: existing_user.email
      fill_in 'Password', with: existing_user.password
      fill_in 'Password confirmation', with: existing_user.password
      click_button 'Sign up'
      expect(page).to have_content 'Email has already been taken'
    end
  end
end
