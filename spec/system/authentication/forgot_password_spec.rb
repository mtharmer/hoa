# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'resetting a forgotten password', type: :system do
  let(:user) { create(:user, :unlocked) }

  it 'does not reset password for non-existent user' do
    visit new_user_password_path
    fill_in 'Email', with: 'some@email.com'
    click_button 'Reset Password'
    expect(User.find_by(email: 'some@email.com')).to be_nil
    expect(page).to have_content 'Email not found'
  end

  it 'sets a reset password token for existing user' do
    visit new_user_password_path
    fill_in 'Email', with: user.email
    click_button 'Reset Password'
    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
    user.reload
    expect(user.reset_password_token).not_to be_nil
  end
end
