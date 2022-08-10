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
    tag_list = params[:post][:tag_ids].split(',')
    if @post.save
      @post.save_tags(tag_list)
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(",")
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_ids].split(',')
    if @post.update(post_params)
      @post.save_tags(tag_list)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :image, :content).merge(user_id: current_user.id)
  end

end
