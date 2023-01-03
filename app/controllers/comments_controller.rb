class CommentsController < ApplicationController
    before_action :set_post
    before_action :set_comment, only: %i(like unlike destroy)

    def create
        @comment = @post.comments.new(comment_params)
        @comment.author = current_user

        if @comment.save
            flash[:notice] = "Comment has been created."
            redirect_to @post
        else
            flash.now[:alert] = "Comment not created, please revise."  
            render "posts/show"
        end
    end

    def new
        @comment = @post.comments.build(parent_id: params[:parent_id])

        if @comment.save
            flash[:notice] = "Reply created!"
            redirect_to @post
        end
    end

    def index
        @comment = @post.comments.build
        @post.comments = @post.comments.where(params[:post_id])
        render "posts/show"
    end

    def like
        @comment.like_by current_user
        redirect_to @post
    end

    def unlike
        @comment.unliked_by current_user
        redirect_to @post
    end

    def destroy
        @comment.destroy

        flash[:notice] = "Comment removed successfully."
        redirect_to post_path(@post)
    end

    private

    def set_post
        @post = Post.find(params[:post_id])
    end

    def set_comment
        @post = Post.find(params[:post_id])
        @comment =  @post.comments.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        flash[:alert] = "This comment does not exist!"
        redirect_to @post
    end

    def comment_params
        params.require(:comment).permit(:text, :scope, :post_id, :parent_id)
    end
end
