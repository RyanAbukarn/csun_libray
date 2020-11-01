class RegistrationsController < ApplicationController
    before_action :require_signin
    def new
        @book = Book.find(params[:book_id])
        @registration = @book.registration.new
    end
    def create 
        @book = Book.find(params[:book_id]) 
        @registration = @book.registration.new(registration_params)
        @registration.user_id = session[:user_id]
        if @registration.save  
            redirect_to "/books", notice: "book successfully booked!"
        else
            render :new
        end
    end
private
    def registration_params
        params.require(:registration).permit(:check_in,:check_out)
    end

end
