class Api::V1::PostsController < ApplicationController
  def index
    user_id = params[:user_id]
    @user = User.includes(:posts).find(user_id)
    render json: @user, status: :ok
  end

  def create
    new_post = current_user.posts.build(post_params)
    if new_post.save
      render json: { message: 'Post created successfully' }, status: :created
    else
      render json: { message: 'An error occured. Please try again!' }, status: :bad_request
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
