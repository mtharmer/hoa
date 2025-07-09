# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  # GET /posts or /posts.json
  def index
    @posts = Post.includes(:comments).order(created_at: :desc)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts or /posts.json
  def create
    new_post = current_user.posts.new(post_params)

    respond_to do |format|
      if new_post.save
        format.html { redirect_to new_post, notice: I18n.t('posts.create.notice') }
        format.json { render :show, status: :created, location: new_post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: new_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: I18n.t('posts.destroy.notice') }
      format.json { head :no_content }
    end
  end

  private

  # Memoize the post lookup to avoid multiple database queries.
  def post
    @post ||= Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:message)
  end
end
