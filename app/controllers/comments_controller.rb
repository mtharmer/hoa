# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  # POST /comments or /comments.json
  def create
    new_comment = create_comment
    respond_to do |format|
      if new_comment.save
        format.html { redirect_to posts_path, notice: I18n.t('comments.create.notice') }
        format.json { render :show, status: :created, location: new_comment }
      else
        format.html { redirect_to posts_path, alert: new_comment.errors.full_messages.to_sentence }
        format.json { render json: new_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    comment.destroy!

    respond_to do |format|
      format.html { redirect_to comments_path, status: :see_other, notice: I18n.t('comments.destroy.notice') }
      format.json { head :no_content }
    end
  end

  private

  # Memoize the comment lookup to avoid multiple database queries.
  def comment
    @comment ||= Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:message, :post_id, :user_id)
  end

  def create_comment
    new_comment = Comment.new(comment_params)
    new_comment.user = current_user
    new_comment
  end
end
