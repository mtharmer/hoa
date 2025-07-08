# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  it { is_expected.to belong_to(:address).optional }
  it { is_expected.to have_many(:posts).dependent(:destroy) }

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe '#admin' do
    it 'returns true if the user is an admin' do
      user = build(:user, admin: true)
      expect(user.admin?).to be true
    end

    it 'returns false if the user is not an admin' do
      user = build(:user, admin: false)
      expect(user.admin?).to be false
    end
  end
end
