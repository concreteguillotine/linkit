class PostsController < ApplicationController
    before_action :set_post, only: %i(show like unlike edit update destroy)

    def index
        if params[:search].present?
            @parameter = params[:search].downcase
            @tags = Tag.where("lower(name) LIKE ?", "%#{@parameter}%")
        else
            @tags = Tag.all
        end
        
        @posts = Post.all

        if params[:scope] == "likes"
            @posts = @posts.orderedl
        else
            @posts = @posts.orderedt
        end
    end

    def tag_index
        @tags = Tag.all 
        @tag = Tag.find(params[:tag_id])
        @posts = Post.where(params[:tag_id] == @tag.id)

        if params[:scope] == "likes"
            @posts = @posts.orderedl
        else
            @posts = @posts.orderedt
        end
    end
    
    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.author = current_user

        @post.tags = processed_tags

        if @post.save
            flash[:notice] = "This post has been added!"
            redirect_to @post
        else
            flash[:notice] = "Post not saved, try again"
            render "new"
        end
    end

    def show
        @comment = @post.comments.build
        @comments = @post.comments.where(params[:post_id])
    end

    def like
        @post.like_by current_user

        redirect_to @post
    end

    def unlike
        @post.unliked_by current_user

        redirect_to @post
    end

    def edit
    end

    def update
        if @post.update(post_params)
            @post.tags << processed_tags

        flash[:notice] = "This post's name has been changed!"
        redirect_to @post
        end
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
        params.require(:post).permit(:name, :image, :text, :url, :youtubeurl)
    end

    def comment_params
        params.permit(:id, :text, :scope, :post_id, :parent_id)
    end

    def processed_tags
        params[:tag_names].split(",").map do |tag|
            Tag.find_or_initialize_by(name: tag.strip)
        end
    end
end
