module ApplicationHelper
    # checks to see if the current user's admin column returns true
    def admins_only(&block)
        block.call if current_user.try(:admin?)
    end

    def users_only(&block)
        block.call if current_user.try(:user?)
    end

    # checks to see if the user has an avatar, if not, the default will display
    def user_avatar(user)
        if user.image.present?
            link_to (image_tag(user.image)), user
        else
            link_to (image_tag("/assets/avatar.png")), user
        end
    end
end
