# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the posts page', type: :system do
  let(:user) { create(:user, locked: false) }

  before do
    sign_in user
  end

  describe 'when there are no posts' do
    it 'shows a message indicating no posts are available' do
      visit posts_path
      expect(page).to have_content('No posts found')
    end
  end

  describe 'when there are posts' do
    let!(:user_post) { create(:post, message: 'First Post', user: user) }
    let!(:other_user_post) { create(:post, message: 'Other Post') }
    let!(:user_comment) { create(:comment, post: user_post, user: user, message: 'First comment') }
    let!(:other_user_comment) { create(:comment, post: user_post, message: 'Second comment') }

    it 'shows the posts' do
      visit posts_path
      within '#posts-list' do
        expect(page).to have_content('First Post')
      end
    end

    it 'allows creating a new post' do
      visit new_post_path
      within '#new-post' do
        fill_in 'Message', with: 'New Post Message'
        click_button 'Create Post'
      end
      expect(page).to have_content('Post was successfully created.')
    end

    it 'shows a comment button' do
      visit posts_path
      within "#post_#{user_post.id}" do
        expect(page).to have_button 'Comment'
      end
    end

    it 'shows delete button' do
      visit posts_path
      within "#post_#{user_post.id}" do
        expect(page).to have_button 'Delete'
      end
    end

    it 'shows an expand button with comment count if the post has comments' do
      visit posts_path
      within "#post_#{user_post.id}" do
        expect(page).to have_button 'See 2 comments'
      end
    end

    it 'does not show the expand button if the post has no comments' do
      visit posts_path
      within "#post_#{other_user_post.id}" do
        expect(page).to have_no_selector('button', text: /See \d+ comment./)
      end
    end

    it 'shows comments for a post' do
      visit posts_path
      within "#post_#{user_post.id}" do
        click_button 'See 2 comments'
        expect(page).to have_content('First comment')
        expect(page).to have_content('Second comment')
      end
    end

    describe 'creating a comment' do
      before do
        visit posts_path
        within "#post_#{user_post.id}" do
          click_button 'Comment'
          fill_in 'Message', with: 'This is a comment'
          click_button 'Create Comment'
        end
      end

      it 'allows creating a comment on a post' do
        expect(page).to have_content('Comment was successfully created.')
        visit posts_path
        within "#post_#{user_post.id}" do
          click_button 'See 3 comments'
          expect(page).to have_content('This is a comment')
        end
      end
    end

    describe 'deleting a comment' do
      before do
        visit posts_path
        within "#post_#{user_post.id}" do
          click_button 'See 2 comments'
        end
      end

      it 'allows deleting a comment' do
        within "#comment_#{user_comment.id}" do
          accept_confirm do
            click_button 'Delete'
          end
        end
        expect(page).to have_content('Comment was successfully destroyed.')
        expect(page).to have_no_content('First comment')
      end

      it 'does not allow deleting a comment by another user' do
        within "#comment_#{other_user_comment.id}" do
          expect(page).to have_no_button('Delete')
        end
      end
    end

    describe 'deleting a post' do
      it 'allows deleting a post' do
        visit posts_path
        within "#post_#{user_post.id}" do
          accept_confirm do
            click_button 'Delete'
          end
        end
        expect(page).to have_content('Post was successfully destroyed.')
      end

      it 'does not allow deleting a post by another user' do
        visit posts_path
        within "#post_#{other_user_post.id}" do
          expect(page).to have_no_button('Delete')
        end
      end
    end
  end

  describe 'pagination' do
    before do
      25.times do
        create(:post, user: user, message: "Post #{rand(1000)}")
      end
    end

    it 'shows paginated posts' do
      visit posts_path
      expect(page).to have_css('#post-pagy-nav')
      expect(page).to have_link '2'
    end

    it 'navigates to the next page' do
      visit posts_path
      page.scroll_to(find_by_id('post-pagy-nav'))
      within '#post-pagy-nav' do
        expect(page).to have_link('>')
        click_link '>'
      end
      expect(page).to have_link '<'
    end

    it 'navigates to the previous page' do
      visit posts_path(page: 2)
      page.scroll_to(find_by_id('post-pagy-nav'))
      within '#post-pagy-nav' do
        expect(page).to have_link('<')
        click_link '<'
      end
      expect(page).to have_link '>'
    end
  end
end
