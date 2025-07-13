# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the signin process', type: :system do
  let(:address) { create(:address) }
  let(:new_address) { create(:address) }
  let(:user) { create(:user, :unlocked, address:) }

  before do
    new_address
    sign_in user
    visit edit_user_registration_path
  end

  it 'allows me to edit my profile' do
    fill_in 'Email', with: user.email
    click_button 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
  end

  it 'allows the email to be changed' do
    fill_in 'Email', with: 'new@email.com'
    click_button 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
    user.reload
    expect(user.email).to eq('new@email.com')
  end

  it 'does not allow an invalid email' do
    original_email = user.email
    fill_in 'Email', with: 'invalid_email'
    click_button 'Update'
    user.reload
    expect(user.email).to eq(original_email)
  end

  it 'allows the name to be changed' do
    fill_in 'Name', with: 'New Name'
    click_button 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
    user.reload
    expect(user.name).to eq('New Name')
  end

  it 'allows the address to be changed' do
    select new_address.address, from: 'Address'
    click_button 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
    user.reload
    expect(user.address).to eq(new_address)
  end
end
