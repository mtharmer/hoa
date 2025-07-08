# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document, type: :model do
  it { is_expected.to have_one_attached(:file) }
  it { is_expected.to validate_presence_of(:file) }
end
