class TagsController < ApplicationController
    def index
    end

    def show
        if params[:search].present?
            @parameter = params[:search].downcase
            @tags = Tag.where("lower(name) LIKE ?", "%#{@parameter}%")
        else
            @tags = Tag.all
        end

        @tag = Tag.find(params[:id])

        @posts = Post.where(params[:tag_id] == @tag.id)

        if params[:scope] == "likes"
            @posts = @posts.orderedl
        else
            @posts = @posts.orderedt
        end
    end
end
