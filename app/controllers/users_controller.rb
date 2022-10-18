class UsersController < ApplicationController
    before_action :set_user, only: %i(show edit update)

    def show
        @posts = Post.all
    end

    def edit
    end

    def update
        @user.update(user_params)

        flash[:notice] = "Profile updated!"
        redirect_to @user
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
