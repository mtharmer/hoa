# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'addresses/new', type: :view do
  before do
    assign(:address, Address.new(
                       address: 'MyString'
                     ))
  end

  it 'renders new address form' do
    render

    assert_select 'form[action=?][method=?]', addresses_path, 'post' do
      assert_select 'input[name=?]', 'address[address]'
    end
  end
end
