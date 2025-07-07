# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before do
    assign(:users, [
             create(:user, name: 'Alice'),
             create(:user, name: 'Bob')
           ])
  end

  it 'renders a list of users' do
    render
    expect(rendered).to match(/Alice/i)
    expect(rendered).to match(/Bob/i)
  end
end
