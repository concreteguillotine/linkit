class Admin::PostsController < Admin::ApplicationController
    before_action :set_post, only: %i(edit update destroy)

    def new
        @post = Post.new 
    end

    def create
        @post = Post.new(post_params)

        if @post.save
            flash[:notice] = "This post has been added!"
            redirect_to @post
        else
        end
    end

    def edit
    end

    def update
        @post.update(post_params)

        flash[:notice] = "This post's name has been changed!"
        redirect_to @post
    end

    def destroy
        @post.destroy
        
        flash[:notice] = "Post successfully removed."
        redirect_to posts_path
    end

private

    def set_post
        @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        flash[:alert] = "This post does not exist!"
        redirect_to posts_path
    end

    def post_params
        params.require(:post).permit(:name, :image)
    end
end