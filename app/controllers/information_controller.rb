class InformationController < ApplicationController
  def summary
    @users_count = User.count
    @last_user = User.last
    @posts_count = Post.count
    @last_post = Post.last
    render json: { 
      users: {
        users_count: @users_count,
        last_user: @last_user
      },
      posts: {
        posts_count: @posts_count,
        last_post: @last_post
      }
    }
  end
end
