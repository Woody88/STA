class PostsController < ApplicationController
  before_action :authenticate_employee!
  respond_to :js

  def index
    @posts = Post.all

    respond_with(@posts)
  end

  def new
    @post = Post.new
  end

  def create
  end

  def update
  end

  def delete
  end

  private

  def posts_params
    params.require(:post).permit(:profile_id, :content)
  end
end
