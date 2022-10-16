module ApplicationHelper
    # checks to see if the current user's admin column returns true
    def admins_only(&block)
        block.call if current_user.try(:admin?)
    end

    def users_only(&block)
        block.call if current_user.try(:user?)
    end
end
