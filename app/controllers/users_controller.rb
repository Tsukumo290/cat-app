class UsersController < ApplicationController

  def index
    @posts = Post.where(user_id: current_user.id).includes(:user).order(created_at: :desc)
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :profile, :email, :image)
  end
end
