require 'rails_helper'

RSpec.describe "Sessions", type: :request do
    before(:each) do
        @userNotAdmin = create(:user)
        @userAdmin =  create(:user, admin: true)
        @userAdmin.save
        @userNotAdmin.save
        
    end
    
    describe "GET index for admin" do
        it "Check if the user is allowed to access this page" do
            post "http://127.0.0.1:3000/session", :params => {email: @userNotAdmin.email, password: "123456"}
            get "http://127.0.0.1:3000/users"
            expect(response).to have_http_status(302)
        end
        it "Return all users" do
            users = User.all
            post "http://127.0.0.1:3000/session", :params => {email: @userAdmin.email, password: "123456"}
            get "http://127.0.0.1:3000/users"
            expect(assigns(:users)).to eq(users)
        end
    end
    
    

end