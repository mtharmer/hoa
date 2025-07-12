# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  let(:user) { create(:user) }

  describe 'without posts' do
    before do
      sign_in user
      assign(:posts, [])
    end

    it 'renders a message indicating no posts are available' do
      render
      expect(rendered).to match(/No posts found/i)
    end
  end

  describe 'with posts' do
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

  describe 'with a post that has comments' do
    let(:post_with_comments) do
      Post.create!(
        message: 'Post with comments',
        user: user
      ).tap do |post|
        post.comments.create!(message: 'First comment', user: user)
        post.comments.create!(message: 'Second comment', user: user)
      end
    end

    before do
      assign(:posts, [post_with_comments])
    end

    it 'renders the post and its comments' do
      render
      expect(rendered).to match(/First comment/)
      expect(rendered).to match(/Second comment/)
    end
  end
end
