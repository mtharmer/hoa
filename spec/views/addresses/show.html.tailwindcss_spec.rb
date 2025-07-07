# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'addresses/show', type: :view do
  before do
    assign(:address, Address.create!(
                       address: 'Address'
                     ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Address/)
  end
end
