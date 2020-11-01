class ApplicationController < ActionController::Base
    private

    def require_signin
        unless current_user
            session[:url] = request.url
            redirect_to new_session_url, alert: "Please sign in first"
        end
    end

    def current_user
        User.find(session[:user_id]) if session[:user_id]
    end
    
    def require_admin
        unless current_user.admin?
            puts current_user.admin
            redirect_to root_url
        end
    end

    def current_user?(user)
        current_user == user
    end
    helper_method :require_admin
    helper_method :current_user 
    helper_method :current_user?
end
