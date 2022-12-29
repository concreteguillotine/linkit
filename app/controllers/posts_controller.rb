class PostsController < ApplicationController
    before_action :set_post, only: %i(show like unlike edit update image destroy)

    def index
        if user_signed_in? && current_user.tags.present?
            @toptags = Tag.all
            @tags = current_user.tags
            @posts = @tags.flat_map(&:posts)

            if params.present?
                if params[:search].present?
                    @parameter = params[:search].downcase
                    @toptags = Tag.where("lower(name) LIKE ?", "#{@parameter}")
    
                elsif params[:tag_id].present?
                    @posts = Post.where(params[:tag_id] == @tag.id)
    
                elsif params[:query] == "all"
                    @toptags = Tag.all
                    @posts = Post.all
                    render "index"
                end
            end

        else
            @toptags = Tag.all
            @posts = Post.all
        end
    end

    def tag_index
        @toptags = Tag.all 
        @tag = Tag.find(params[:tag_id])
        @posts = Post.where(params[:tag_id] == @tag.id)
    end
    
    def new
        @post = Post.new
        
        if params[:query] == "text"
            render "posts/_textform"
        elsif params[:query] == "image"
            render "posts/_imageform"
        elsif params[:query] == "video"
            render "posts/_videoform"
        elsif params[:query] == "link"
            render "posts/_linkform"
        end
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
        @post.comments = @post.comments.where(params[:post_id])
    end

    def like
        @post.like_by current_user

        redirect_back(fallback_location: root_path)
    end

    def unlike
        @post.unliked_by current_user

        redirect_back(fallback_location: root_path)
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

    def image
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
        params.require(:post).permit(:name, :image, :text, :url, :youtubeurl, :query)
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
