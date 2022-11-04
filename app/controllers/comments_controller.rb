class CommentsController < ApplicationController
    before_action :set_post

    def create
        @comment = @post.comments.new(comment_params)
        @comment.author = current_user

        if @comment.save
            flash[:notice] = "Comment has been created!"
            redirect_to @post
        else
            flash.now[:alert] = "Comment not created, please revise."  
            render "posts/show"
        end
    end

    def new
        @comment = @post.comments.build(parent_id: params[:parent_id])
    end

    def index
        @comment = @post.comments.build
        @comments = @post.comments.where(params[:post_id])

        if params[:scope] == "likes"
            @comments = @comments.orderedl
        else
            @comments = @comments.orderedt
        end

        render "posts/show"
    end

    def like
        @comment = @post.comments.find(params[:comment_id])
        @comment.like_by current_user
        redirect_to @post
    end

    def unlike
        @comment = @post.comments.find(params[:comment_id])
        @comment.unliked_by current_user
        redirect_to @post
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
        params.require(:comment).permit(:text, :scope, :post_id, :parent_id)
    end
end
