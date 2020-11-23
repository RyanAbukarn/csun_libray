class UsersController < ApplicationController
    
    before_action :require_signin , except: [:new, :create]
    before_action :require_admin, only: [:index]
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
        @user.admin = make_user_admin
        if @user.save
            if !make_user_admin
                #UserMailer.with(user: @user).welcome_email.deliver_later
                session[:user_id] = @user.id
                redirect_to @user, notice: "Account successfully created!"
            else
                UserMailer.with(user: @user).welcome_email.deliver_later
                redirect_to books_url, notice: "Admin Account successfully created!"
            end
        else
            flash.now[:error] = "The email is alredy in use. Please use another."
            render action: "new"
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        session[:user_id] = nil
        redirect_to root_url, notice: "Account successfully deleted!"
    end

    def show
        @user = User.find(params[:id])
        @BookedRegistrations = @user.registration.where("is_checked_in = false").order(:check_out)
        @HasRegistrations = @user.registration.where("is_checked_in = true and is_checked_out=false").order(:check_out)
    end

private

    def redirect_correct_user
        if User.exists?(params[:id])
            @user = User.find(params[:id])
            unless current_user?(@user)
                redirect_to root_url  
            end
        else
            redirect_to books_url
        end
    end 

    def user_perams
        params.require(:user).permit(:fname,:lname,:email,:phone,:address,:city,:state,:password)
    end



end

