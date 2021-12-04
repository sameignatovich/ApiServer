class InformationController < ApplicationController
  def summary
    @users_count = User.count
    @last_user = User.last
    @posts_count = Post.count
    @last_post = Post.includes(:user).last
    @comments_count = Comment.count
    @last_comment = Comment.includes(:user).includes(:post).last
  end
end
