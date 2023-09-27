class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: 'Comment was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end
end
