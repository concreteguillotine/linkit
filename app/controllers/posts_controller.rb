class PostsController < ApplicationController
    before_action :set_post, only: %i(show like unlike edit update destroy)

    def index
        @posts = Post.all
    end

    def show
        @comment = @post.comments.build
    end

    def like
        @post.like_by current_user

        respond_to do |f|
            f.html { redirect_to post_path }
            f.turbo_stream
        end
    end

    def unlike
        @post.unliked_by current_user

        respond_to do |f|
            f.html { redirect_to post_path }
            f.turbo_stream
        end
    end

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
