# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the signin process', type: :system do
  let(:user) { create(:user, locked: false) }

  before do
    sign_in user
    visit edit_user_registration_path
  end

  it 'allows me to edit my profile' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'New Password'
    fill_in 'Password confirmation', with: 'New Password'
    fill_in 'Current password', with: user.password
    click_button 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
    # user.reload
    # expect(user.name).to eq('New Name')
    # expect(user.email).to eq('New Password')
  end

  it 'shows an error when the current password is incorrect' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'New Password'
    fill_in 'Password confirmation', with: 'New Password'
    fill_in 'Current password', with: 'Wrong Password'
    click_button 'Update'
    expect(page).to have_content('Current password is invalid')
  end

  it 'allows the email to be changed' do
    fill_in 'Email', with: 'new@email.com'
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    fill_in 'Current password', with: user.password
    click_button 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
    user.reload
    expect(user.email).to eq('new@email.com')
  end

  it 'allows the password to be changed' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'New Password'
    fill_in 'Password confirmation', with: 'New Password'
    fill_in 'Current password', with: user.password
    click_button 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
    user.reload
    expect(user.valid_password?('New Password')).to be true
  end
end
