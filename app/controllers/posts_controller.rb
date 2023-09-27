class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!


  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "Post created successfully"
    else
      render :new
    end
  end

  def update
      if @post.update(post_params)
        redirect_to posts_path, notice: "Post successfully updated."
      else
        render :edit
      end
    end

  def destroy
    if @post.destroy
      redirect_to posts_url, notice: "Post was successfully destroyed."
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
