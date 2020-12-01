require 'rails_helper'

RSpec.describe SessionsController, type: :request do
    before(:each) do
        @userNotAdmin = create(:user)
        @userAdmin =  create(:user, admin: true)
        post  "/session", :params => {email: @userAdmin.email, password: "123456"}
    end
    describe "GET index for admin" do
        it "Check if the user is allowed to access other users pages" do
            delete "/session" #signout user
            expect(response).to have_http_status(302)
            post  "/session", :params => {email: @userNotAdmin.email, password: "123456"}
            get "/users/#{@userAdmin.id}"
            expect(response).to have_http_status(302)
        end
        it "Check if the user can accese his/her page" do
            get "/users/#{@userAdmin.id}"
            expect(response).to have_http_status(200)
        end
        it "Return all users" do
            users = User.all
            get "/all_users"
            expect(response).to render_template(:all_users)
            expect(assigns(:users)).to eq(users)
        end
        it "Delete account" do
            delete "/users/#{@userAdmin.id}"
            post  "/session", :params => {email: @userAdmin.email, password: "123456"}
            get "/users/#{@userAdmin.id}"
            expect(response).to have_http_status(302)
        end
    end
end