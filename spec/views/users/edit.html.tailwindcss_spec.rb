# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/edit', type: :view do
  let(:user) do
    create(:user, name: 'Alice')
  end

  before do
    assign(:user, user)
  end

  it 'renders the edit user form' do
    render

    expect(rendered).to match(/Editing User/i)
    expect(rendered).to match(/Alice/i)
  end
end
