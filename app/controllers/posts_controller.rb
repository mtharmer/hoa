# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[destroy]
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
    @post = current_user.posts.new(post_params)
    super(@post) # Calls the create method from ApplicationController
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    super(@post, posts_path) # Calls the destroy method from ApplicationController
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:message)
  end
end
