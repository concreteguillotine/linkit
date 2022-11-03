class TagsController < ApplicationController
    def index
    end

    def show
        @tags = Tag.all
        @tag = Tag.find(params[:id])

        @posts = Post.where(params[:tag_id] == @tag.id)

        if params[:scope] == "likes"
            @posts = @posts.orderedl
        else
            @posts = @posts.orderedt
        end
    end
end
