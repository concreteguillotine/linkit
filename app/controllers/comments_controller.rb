class CommentsController < ApplicationController
    before_action :set_post

    def create
        @comment = @post.comments.build(comment_params)
        @comment.author = current_user

        if @comment.save
            flash[:notice] = "Comment has been created!"
            redirect_to @post
        else
            flash.now[:alert] = "Comment not created, please revise."  
            render "posts/show"
        end
    end

    def destroy
        @comment = @post.comments.find(params[:id])
        @comment.destroy

        flash[:notice] = "Comment removed successfully."
        redirect_to post_path(@post)
    end

    private

    def set_post
        @post = Post.find(params[:post_id])
    end

    def comment_params
        params.require(:comment).permit(:text)
    end
end
