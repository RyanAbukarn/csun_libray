class RegistrationsController < ApplicationController
    before_action :require_signin
    before_action :require_admin, only: [:edit, :update]

    def new
        @book = Book.find(params[:book_id])
        @registration = @book.registration.new
    end

    def destroy
        #book_id is registration id
        @reg = Registration.find(params[:book_id])
        @reg.destroy
        redirect_to user_url, notice: "Order is successfully canceled!"
    end

    def create

        start = covert_datetime(registration_params,"check_in") 
        ends = covert_datetime(registration_params,"check_out")

        @book = Book.find(params[:book_id])
        @registration = @book.registration.new(registration_params)
        @registration.user_id = session[:user_id] 

        if(date_validation(start,ends))
            if Registration.is_available_to_rent(params[:book_id],start,ends)
                if @registration.save  
                    redirect_to "/books", notice: "book successfully booked!"
                end
            else 
                render :new, notice: "Already booked!"
            end 
        else
            render :new, notice: "chick-in date is bigger than check-out date"
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

        start = covert_datetime(registration_params,"check_in") 
        ends = covert_datetime(registration_params,"check_out")
        if(date_validation(start,ends))
            if is_the_user_has_book
                if @registration.update(registration_params)  
                    redirect_to "/users", notice: "updated successfully"
                end
            elsif is_the_book_retured
                @registration.destroy
                redirect_to "/books", notice: "The book is available"
            end
        else
            render :new, notice: "chick-in date is bigger than check-out date"
        end
    end

    private
        def registration_params
            params.require(:registration).permit(:check_in,:check_out,:is_checked_out,:is_checked_in)
        end

        def covert_datetime(paramDate,string)
            DateTime.new(paramDate["#{string}(1i)"].to_i ,paramDate["#{string}(2i)"].to_i, paramDate["#{string}(3i)"].to_i, paramDate["#{string}(4i)"].to_i, paramDate["#{string}(5i)"].to_i)
        end
        
        def returned(is_return)
            if is_return != nil
                is_return=="false" ? false : true
            else
                false
            end
        end


end
