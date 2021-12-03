class InformationController < ApplicationController
  def summary
    @users_count = User.count
    @last_user = User.last
    @posts_count = Post.count
    @last_post = Post.last
  end
end
