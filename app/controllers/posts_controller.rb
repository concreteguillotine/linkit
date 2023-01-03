class PostsController < ApplicationController
    before_action :set_post, only: %i(show like unlike edit update image destroy)
    before_action :toptags, only: %i(index tag_index)

    def index
        # if the person viewing this is signed in and follows some tags..
        if user_signed_in? && current_user.tags.present?

            # ..the tags are their followed tags..
            @tags = current_user.tags

            # ..and a joins query is used to assign the @posts variable
            # to all of the posts that have those tags
            @posts = Post.joins(:tags).
                          where('tags.id IN (?)', 
                          current_user.tags.select(:tag_id)).distinct

            if params.present?
                if params[:search].present?
                    @parameter = params[:search].downcase
                    @toptags = Tag.where("lower(name) LIKE ?", "#{@parameter}")
    
                elsif params[:tag_id].present?
                    @posts = Post.where(params[:tag_id] == @tag.id)
    
                elsif params[:query] == "all"
                    @posts = Post.all
                    render "index"
                end
            end
        else
            @posts = Post.all
        end
    end

    def tag_index
        @tag = Tag.find(params[:tag_id])
        @posts = Post.where(params[:tag_id] == @tag.id)
    end
    
    def new
        @post = Post.new

        render "posts/_#{params[:query]}form"
    end

    def create
        @post = Post.new(post_params)
        @post.author = current_user

        @post.tags = processed_tags

        if @post.save
            flash[:notice] = "This post has been added."
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

    def update
        if @post.update(post_params)
            @post.tags << processed_tags

        flash[:notice] = "Post edited."
        redirect_to @post
        end
    end

    def destroy
        @post.destroy
        
        flash[:notice] = "Post successfully removed."
        redirect_to posts_path
    end

    def edit
    end

    def image
    end

    private

    def set_post
        @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        flash[:alert] = "This post does not exist!"
        redirect_to posts_path
    end

    def toptags
        @toptags = Tag.all
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
