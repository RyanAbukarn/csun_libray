class UsersController < ApplicationController
    
    before_action :require_signin , except: [:new, :create]
    before_action :require_admin, except: [:edit, :update, :destory,:show]
    before_action :redirect_correct_user, only: [:edit, :update, :show, :destory]
    def index
        @users = User.all
    end
    def new
        @user = User.new 
    end
    def edit
    end 
    def update
        if @user.update(user_perams)
            redirect_to @user, notice: "Account successfully updated!"
        else 
            render :edit
        end
    end

    def create
        @user = User.new(user_perams)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user, notice: "Account successfully created!"
        else 
            render :new
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        session[:user_id] = nil
        redirect_to root_url
    end
    def show
        @user = User.find(params[:id])
        @registrations = @user.registration.order(:check_out)
    end
    private
    def redirect_correct_user
        @user = User.find(params[:id])
        unless current_user?(@user)
            redirect_to root_url  
        end
    end 
    def user_perams
        params.require(:user).permit(:fname,:lname,:email,:phone,:address,:city,:state,:password)
    end  

end

