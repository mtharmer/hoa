# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the signin process', type: :system do
  describe 'when the user is not locked' do
    let(:user) { create(:user, locked: false) }

    it 'signs me in' do
      visit new_user_session_path
      expect(page).to have_content 'Log in'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully'
    end
  end

  describe 'when the user is locked' do
    let(:user) { create(:user, locked: true) }

    it 'does not sign me in' do
      visit new_user_session_path
      expect(page).to have_content 'Log in'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(page).to have_content 'Your account is locked'
    end
  end

  describe 'with bad credentials' do
    let(:user) { create(:user, locked: false) }

    it 'does not sign me in' do
      visit new_user_session_path
      expect(page).to have_content 'Log in'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'wrongpassword'
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password'
    end
  end

  it 'has a link to sign up' do
    visit new_user_session_path
    expect(page).to have_link 'Sign up', href: new_user_registration_path
  end

  it 'has a link to reset password' do
    visit new_user_session_path
    expect(page).to have_link 'Forgot your password?', href: new_user_password_path
  end
end
