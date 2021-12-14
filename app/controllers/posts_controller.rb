class PostsController < ApplicationController
  before_action :check_authorization
  before_action :set_post, only: %i[ show update destroy ]
  
  has_scope :username, only: :index
  has_scope :tag, only: :index

  # GET /posts
  # GET /posts.json
  def index
    @posts = apply_scopes(Post).includes(:user)
                               .page(params[:page] ? params[:page] : 1)
                               .per(params[:perPage] ? params[:perPage] : 10)
    @posts_count = apply_scopes(Post).count
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
