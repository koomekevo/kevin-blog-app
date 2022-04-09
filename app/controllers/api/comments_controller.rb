class Api::V1::CommentsController < ApplicationController
  def index
    @post = Post.includes(:comments).find_by(id: params[:post_id])
    render json: @post.comments, status: :ok
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(text: comment_parameters[:text], author_id: current_user.id, post_id: @post.id)
    if @comment.save
      render json: { message: 'Comment created successfully' }, status: :created
    else
      render json: { message: 'An error occured, please try again!' }, status: :bad_request
    end
  end

  private

  def comment_parameters
    params.require(:comment).permit(:text)
  end
end
