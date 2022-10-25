class TagsController < ApplicationController
    def index
    end

    def show
        @tag = Tag.find(params[:id])

        @posts = Post.where(params[:tag_id] == @tag.id)
    end
end
