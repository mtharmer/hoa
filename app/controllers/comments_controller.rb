# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy]
  before_action :create_comment, only: %i[create]
  before_action :authenticate_user!

  # POST /comments or /comments.json
  def create
    respond_to do |format|
      if @comment.save
        format.html { redirect_to posts_path, notice: I18n.t('comments.create.notice') }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to posts_path, alert: ::Util.to_sentence(@comment) }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    if @comment.user != current_user
      flash[:alert] = I18n.t('comments.destroy.alert')
      redirect_to posts_path and return
    end
    super(@comment, posts_path) # Calls the destroy method from ApplicationController
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:message, :post_id, :user_id)
  end

  def create_comment
    @comment = Comment.new(comment_params)
    @comment.user = current_user
  end
end
