
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
        def is_user_admin
            current_user.admin?    
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
        def authenticate_user
            token , _option = token_and_options(request)
            if token.nil?
                token = http_auth_header
            end
            user_id = AuthenticationTokenService.decode(token)
            User.find(user_id)
            rescue ActiveRecord::RecordNotFound
                render json: {statues: :unauthorized} , statues: :unauthorized  
        end
        def http_auth_header
            token = params["headers"]["Authorization"].split(" ")[1]
            if token.present?
              return  params["headers"]["Authorization"].split(" ")[1]
            else
                nil
            end
        end
        # def session_user
        #     decoded_hash = decoded_token
        #     if !decoded_hash.empty?
                
        #     end
        # end
    helper_method :authenticate_user
    helper_method :make_user_admin
    helper_method :date_validation
    helper_method :require_admin
    helper_method :current_user 
    helper_method :current_user?
end
