# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'changing passwords', type: :system do
  let(:user) { create(:user, :unlocked) }

  before do
    sign_in user
    visit edit_user_registration_path
  end

  it 'allows the user to change their password' do
    fill_in 'Password', with: 'newpassword123'
    fill_in 'Password confirmation', with: 'newpassword123'
    fill_in 'Current password', with: user.password
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
    user.reload
    expect(user.valid_password?('newpassword123')).to be true
  end

  it 'does not allow changing password without current password' do
    fill_in 'Password', with: 'newpassword123'
    fill_in 'Password confirmation', with: 'newpassword123'
    click_button 'Update'

    expect(page).to have_content('Current password can\'t be blank')
    user.reload
    expect(user.valid_password?('newpassword123')).to be false
  end

  it 'does not allow changing password with mismatched confirmation' do
    fill_in 'Password', with: 'newpassword123'
    fill_in 'Password confirmation', with: 'differentpassword'
    fill_in 'Current password', with: user.password
    click_button 'Update'

    expect(page).to have_content('Password confirmation doesn\'t match Password')
    user.reload
    expect(user.valid_password?('newpassword123')).to be false
  end
end
