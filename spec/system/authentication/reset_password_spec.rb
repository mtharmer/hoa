# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'resetting the password with a token', type: :system do
  let(:user) { create(:user, :unlocked) }

  before do
    user
    token = user.send_reset_password_instructions
    visit edit_user_password_path(reset_password_token: token)
  end

  it 'allows the user to reset their password' do
    fill_in 'New password', with: 'newpassword123'
    fill_in 'Confirm new password', with: 'newpassword123'
    click_button 'Change my password'

    expect(page).to have_content('Your password has been changed successfully.')
    expect(user.reload.valid_password?('newpassword123')).to be true
  end
end
