# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  let(:user) { create(:user) }

  before do
    assign(:posts, [
             Post.create!(
               message: 'Some Message',
               user:
             ),
             Post.create!(
               message: 'Another Message',
               user:
             )
           ])
  end

  it 'renders a list of posts' do
    render
    expect(rendered).to match(/Some Message/)
    expect(rendered).to match(/Another Message/)
  end
end
