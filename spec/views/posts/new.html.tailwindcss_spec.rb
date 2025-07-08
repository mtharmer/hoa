# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/new', type: :view do
  let(:user) { create(:user) }

  before do
    assign(:post, Post.new(
                    message: 'MyText',
                    user:
                  ))
  end

  it 'renders new post form' do
    render
    expect(rendered).to match(/Message/)
    expect(rendered).to match(/Create Post/)

    assert_select 'form[action=?][method=?]', posts_path, 'post' do
      assert_select 'textarea[name=?]', 'post[message]'
    end
  end
end
