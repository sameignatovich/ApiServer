class StatisticsController < ApplicationController
  def summary
    @users_count = User.count
    @last_user = User.first
    @posts_count = Post.count
    @last_post = Post.first
    @comments_count = Comment.count
    @last_comment = Comment.last # .includes(:user).includes(:post)
  end

  def platforms
    @devices = Token.unscope(:order).group(:device).count
    @browsers = Token.unscope(:order).group(:browser).count
  end
end
