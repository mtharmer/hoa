require 'rails_helper'

RSpec.describe "home/index", type: :view do
  it 'renders the index template' do
    render

    expect(rendered).to match(/Home#Index/i)
  end
end
