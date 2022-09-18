class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def authenticate_admin!
        unless user_signed_in? && current_user.is_admin?
            flash[:notice] = "You are not authorize to access this page."
            redirect_to root_url
        end
    end
end
