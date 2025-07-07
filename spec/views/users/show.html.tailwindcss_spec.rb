# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  before do
    assign(:user, create(:user, name: 'Alice'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Alice/i)
  end
end
