# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'addresses/index', type: :view do
  describe 'without addresses' do
    before do
      assign(:addresses, [])
    end

    it 'renders a message indicating no addresses are available' do
      render
      expect(rendered).to match(/No addresses found/i)
    end
  end

  describe 'with addresses' do
    before do
      assign(:addresses, [
               Address.create!(
                 address: '123 Main St'
               ),
               Address.create!(
                 address: '456 Elm St'
               )
             ])
    end

    it 'renders a list of addresses' do
      render
      expect(rendered).to match(/123 Main St/i)
      expect(rendered).to match(/456 Elm St/i)
    end
  end
end
