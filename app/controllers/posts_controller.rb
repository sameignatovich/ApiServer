class PostsController < ApplicationController
  before_action :check_authorization
  before_action :set_post, only: %i[ show update destroy ]
  
  # GET /posts
  # GET /posts.json
  def index
    query_filters = {}

    if params[:user_id]
      query_filters['user_id'] = params[:user_id]
    end
    if params[:tag]
      query_filters['tags'] = { name: params[:tag] }
    end

    @posts = Post.joins(:tags)
                 .where(query_filters)
                 .includes(:user)
                 .page(params[:page] ? params[:page] : 1)
                 .per(params[:perPage] ? params[:perPage] : 10)
    @posts_count = Post.count
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @tags = @post.tags
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render :show, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(post_params)
      render :show, status: :ok, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :text, tags_list: [])
    end
end
