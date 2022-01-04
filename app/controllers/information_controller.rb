class InformationController < ApplicationController
  def summary
    @users_count = User.count
    @last_user = User.first
    @posts_count = Post.count
    @last_post = Post.first
    @comments_count = Comment.count
    @last_comment = Comment.last # .includes(:user).includes(:post)
  end
end
