class RegistrationsController < ApplicationController
    before_action :require_signin
    before_action :require_admin, only: [:edit, :update]

    def new
        @book = Book.find(params[:book_id])
        @registration = @book.registration.new
    end

    def destroy
        #book_id is registration id
        reg = Registration.find(params[:book_id])
        if !reg.is_checked_in && reg.destroy
            redirect_to user_url, notice: "Order is successfully canceled!"
        else 
            redirect_to user_url, notice: "Order is not successfully canceled!"
        end
    end

    def create
        @book = Book.find(params[:book_id])
        @registration = @book.registration.new(registration_params)
        @registration.user_id = session[:user_id] 
        if Registration.is_available_to_rent(@book.id,@registration.check_in,@registration.check_out) && @registration.save  
            redirect_to "/books", notice: "book successfully booked!"
        else 
            render :new, notice: "Already booked!"
        end 
    end

    def edit
        @registration = Registration.find(params[:id])
        @book = @registration.book
    end

    def update
        is_the_user_has_book = returned(params[:registration][:is_checked_in])
        is_the_book_retured = returned(params[:registration][:is_checked_out])
        @registration = Registration.find(params[:id])
        if is_the_user_has_book
            if @registration.update(registration_params)  
                redirect_to "/users", notice: "updated successfully"
            else
                render :new, notice: "chick-in date is bigger than check-out date"
            end
        elsif is_the_book_retured
            @registration.destroy
            redirect_to "/books", notice: "The book is available"
        end
    end

    private
        def registration_params
            if is_user_admin
                params.require(:registration).permit(:check_in,:check_out,:is_checked_out,:is_checked_in)
            else
                params.require(:registration).permit(:check_in,:check_out)
            end
        end


        
        def returned(is_return)
            if is_return != nil
                is_return
            else
                false
            end
        end


end
