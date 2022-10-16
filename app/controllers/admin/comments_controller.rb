class Admin::CommentsController < Admin::ApplicationController
  before_action :set_post, only: %i(destroy)

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    flash[:notice] = "Comment removed successfully."
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "This Margot does not exist!"
    redirect_to posts_path
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
