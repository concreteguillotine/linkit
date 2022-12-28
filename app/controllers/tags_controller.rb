class TagsController < ApplicationController
    before_action :set_tag, only: %i(follow unfollow)

    def index
    end

    def show
        if params[:search].present?
            @parameter = params[:search].downcase
            @tags = Tag.where("lower(name) LIKE ?", "%#{@parameter}%")
        else
            @toptags = Tag.all
        end

        @tag = Tag.find(params[:id])

        @posts = Post.where(params[:tag_id] == @tag.id)
    end

    def follow
        current_user.tags << @tag
        redirect_back(fallback_location: tag_path(@tag))
    end

    def unfollow
        current_user.followed_tags.find_by(tag_id: @tag.id).destroy
        redirect_back(fallback_location: tag_path(@tag))
    end

    private

    def set_tag
        @tag = Tag.find(params[:id])
    end
end
