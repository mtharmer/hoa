# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  it { is_expected.to have_many(:users).dependent(:restrict_with_error) }

  it { is_expected.to validate_presence_of(:address) }
end
