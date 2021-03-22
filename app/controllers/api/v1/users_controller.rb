module Api
    module V1
        class UsersController < ApplicationController
            skip_before_action :verify_authenticity_token
            before_action :authenticate_user
            include ActionController::HttpAuthentication::Token

            def rent
                book = Book.find(params[:book_id])
                registration = book.registration.new(registration_params)
                registration.user_id = authenticate_user.id
                 
                if Registration.is_available_to_rent(book.id,registration.check_in,registration.check_out) && registration.save  
                    render json: {registration: registration, statues: true,message: "created succefully"}
                else 
                    render json: {statues: false,message: "something is wrong"}
                end 
            end
            def update_registration
                @registration = Registration.find(params[:id])
                is_the_user_has_book = @registration.is_checked_in
                if !is_the_user_has_book
                    if @registration.update(registration_params)  
                        render json: {statues: true}
                    else
                        render json: {statues: false}
                    end
                else
                    render json: {statues: "hasTheBook"}
                end
               
            end
     
            def my_library
                user = authenticate_user
                bookedRegistrations = user.registration.where("is_checked_in = false").order(:check_out)
                bookedRegistrations = bookedRegistrations.map{ |bookedRegistration| bookedRegistration.book.as_json.merge!("registration_id"=>bookedRegistration.id, "is_checked_in"=> bookedRegistration.is_checked_in,"check_out"=>bookedRegistration.check_out,"check_in"=>bookedRegistration.check_in)}
                hasRegistrations = user.registration.where("is_checked_in = true and is_checked_out=false").order(:check_out)
                hasRegistrations = hasRegistrations.map{ |hasRegistration| hasRegistration.book.as_json.merge!("registration_id"=>hasRegistration.id, "is_checked_in"=> hasRegistration.is_checked_in,"check_out"=>hasRegistration.check_out,"check_in"=>hasRegistration.check_in) }

                render json: {BookedRegistrations: bookedRegistrations, HasRegistrations: hasRegistrations }
            end
            def my_account
                user = authenticate_user
                render json: {accountInfo: user}
            end
        
            def edit_my_account
                if authenticate_user.update(user_perams)
                    render json: {statues: "Updated"}                
                else 
                    render json: {statues: false}
                end
            end
            def destroy_registration
                reg = Registration.find(params[:book_id])
                if !reg.is_checked_in && reg.destroy
                    render json: {statues: true}                
                else 
                    render json: {statues: false}
                end
            end

        
            def delete_my_account
                if !authenticate_user.registration.any?
                    authenticate_user.destroy
                    render json: {statues: true}
                else
                    render json: {statues: false}
                end
            end
        
        private     
        def user_perams
            params.require(:user).permit(:fname,:lname,:email,:phone,:address,:city,:state,:password)
        end
            
            def registration_params

                params.require(:registration).permit(:check_in,:check_out)
            
            end
    
    
            
            def returned(is_return)
                if is_return != nil
                    is_return
                else
                    false
                end
            end
        end
    end
end


