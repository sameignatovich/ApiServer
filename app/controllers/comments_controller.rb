class CommentsController < ApplicationController

  # GET /posts/:id/comments
  # GET /posts/:id/comments.json
  def show
    @comments = Comment.includes(:user).where(post_id: params[:id])
  end
end
