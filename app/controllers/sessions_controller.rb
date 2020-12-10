class SessionsController < ApplicationController
    def new 
    end
    def create 
        if user = User.auth(params[:email],params[:password])
            session[:user_id] = user.id
            redirect_to(session[:url] || user)
            session[:url] = nil
        else
            redirect_to "/session/new", notice: "Wrong password/email" 
        end
    end
    def destroy
        session[:user_id] = nil
        redirect_to root_url, notice: "Now you are signed out bye!" 
    end
end
