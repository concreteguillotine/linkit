class UsersController < ApplicationController
    before_action :set_user, except: %i( replies comments )

    def show
        @posts = Post.order(cached_votes_total: :desc).where(author: @user)
        @comments = Comment.where(author: @user)
        @tags = Tag.joins(:posts).
                    where('posts.id IN (?)', 
                    @posts.select(:post_id)).distinct
    end

    def edit
    end

    def update
        @user.update(user_params)

        flash[:notice] = "Profile updated!"
        redirect_to @user
    end
    
    def replies
        @user = User.find(params[:id])
        @comments = Comment.where(author: @user)
    end

    def comments
        @user = User.find(params[:id])
        @posts = Post.order(cached_votes_total: :desc).where(author: @user)
    end

    private

    def set_user
        @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        flash[:alert] = "This user does not exist!"
        redirect_to posts_path
    end

    def user_params
        params.require(:user).permit(:username, :image, :email, :password, :about)
    end
end
