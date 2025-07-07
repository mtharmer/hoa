require 'rails_helper'

RSpec.describe 'addresses/index', type: :view do
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
