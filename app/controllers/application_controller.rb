class ApplicationController < ActionController::Base
    def cities
        render json: CS.cities(params[:state], :us).to_json
    end
   
    
    private

        def require_signin
            unless current_user
                session[:url] = request.url
                redirect_to new_session_url, notice: "Please sign in first"
            end
        end

        def current_user
            User.find(session[:user_id]) if session[:user_id]
        end
    
        def require_admin
            unless current_user.admin?
                redirect_to root_url
            end
        end

        def current_user?(user)
            current_user == user
        end

        def date_validation(start,ends)
            start < ends
        end
    
        def make_user_admin
            current_user == nil ? false : current_user.admin?
        end
        

    helper_method :make_user_admin
    helper_method :date_validation
    helper_method :require_admin
    helper_method :current_user 
    helper_method :current_user?
end
