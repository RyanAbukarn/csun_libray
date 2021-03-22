module Api
    module V1
        class AuthenticationController < ApplicationController
            skip_before_action :verify_authenticity_token

            class AuthenticationError < StandardError; end
            rescue_from ActionController::ParameterMissing, with: :parameter_missng
            rescue_from AuthenticationError, with: :handle_unauthenticate

            def create               
                if user
                    user.authenticate(params.require(:password))
                    token = AuthenticationTokenService.encode(user.id)  
                    render json: {token: token, statues: true}, statues: :created
                else
                    render json: {statues: false}, statues: :created
                end

            end
            def create_new_account
                @user = User.new(user_perams)
                if @user.save
                    token = AuthenticationTokenService.encode(@user.id)
                    render json: {token: token, statues: "Created"}, statues: :created
                else
                    render json: {statues: false}
                end
            end

            
        private

            def user_perams
                params.require(:user).permit(:fname,:lname,:email,:phone,:address,:city,:state,:password)
            end

            def user
                @user ||= User.find_by(email: params.require(:email))
            end
            def handle_unauthenticate
                head :unauthorized
            end
            def parameter_missng(e)
                render json: { error: e.message }, statues: :unprocessable_entity
            end
        end
    end
end