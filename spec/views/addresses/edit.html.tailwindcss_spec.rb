# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'addresses/edit', type: :view do
  let(:address) do
    Address.create!(
      address: 'MyString'
    )
  end

  before do
    assign(:address, address)
  end

  it 'renders the edit address form' do
    render

    assert_select 'form[action=?][method=?]', address_path(address), 'post' do
      assert_select 'input[name=?]', 'address[address]'
    end
  end
end
