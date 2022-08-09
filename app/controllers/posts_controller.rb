class PostsController < ApplicationController

  def index
    @posts = Post.order(created_at: :desc)
    @my_posts = Post.where(user_id: current_user.id).includes(:user).order(created_at: :desc).limit(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :image, :content).merge(user_id: current_user.id)
  end

end
