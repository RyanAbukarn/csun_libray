require 'rails_helper'

RSpec.describe RegistrationsController, type: :request do
    before(:each) do
        @userAdmin = create(:user,admin: true)
        @user = create(:user)
        @books1 = create_list(:book,2)
    end
    context "when the user is not admin" do
        it "Renting a book with logged in user"  do
            post  "/session", :params => {email: @user.email, password: "123456"}
            post "/books/#{@books1[0].id}/registrations/", :params => {:registration => {check_in:"2020-12-25 03:23 AM",check_out:"2020-12-27 03:23 AM"}}
            expect(Registration.where(user_id: "#{@user.id}")).to eq(@user.registration) 
        end
        it "Will not allow renting a book with not logged in user"  do
            post "/books/#{@books1[0].id}/registrations/", :params => {:registration => {check_in:"2020-12-25 03:23 AM",check_out:"2020-12-27 03:23 AM"}}
            expect(response).to have_http_status(302)
            expect(Registration.where(user_id: "#{@user.id}").count).to equal(0) 
        end
        it "Will not allow renting a book that is not DB"  do
            post "/books/#{10}/registrations/", :params => {:registration => {check_in:"2020-12-25 03:23 AM",check_out:"2020-12-27 03:23 AM"}}
            expect(response).to have_http_status(302)
            expect(Registration.where(user_id: "#{@user.id}").count).to equal(0) 
        end
        it "Will not allow renting a with check out bigger than check in"  do
            post  "/session", :params => {email: @user.email, password: "123456"}
            post "/books/#{@books1[0].id}/registrations/", :params => {:registration => {check_in:"2020-12-25 03:23 AM",check_out:"2020-12-20 03:23 AM"}}
            expect(Registration.where(user_id: "#{@user.id}").count).to equal(0) 
        end
        it "Will not allow renting a book with same check out and check in"  do
            post  "/session", :params => {email: @user.email, password: "123456"}
            post "/books/#{@books1[0].id}/registrations/", :params => {:registration => {check_in:"2020-12-25 03:23 AM",check_out:"2020-12-26 03:23 AM"}}
            post "/books/#{@books1[0].id}/registrations/", :params => {:registration => {check_in:"2020-12-25 03:23 AM",check_out:"2020-12-26 03:23 AM"}}
            expect(Registration.where(user_id: "#{@user.id}").count).to equal(1) 
        end
        it "Will cancle renting a book if it not picked yet"  do
            post  "/session", :params => {email: @user.email, password: "123456"}
            post "/books/#{@books1[0].id}/registrations/", :params => {:registration => {check_in:"2020-12-24 03:23 AM",check_out:"2020-12-26 03:23 AM"}}
            registation_id = Registration.where(user_id: "#{@user.id}").ids
            delete "/books/#{registation_id[0]}/registrations/1"
            expect(Registration.where(user_id: "#{@user.id}").count).to equal(0) 
        end
        it "Will not cancle renting a book if it picked alredy"  do
            post  "/session", :params => {email: @user.email, password: "123456"}
            post "/books/#{@books1[0].id}/registrations/", :params => {:registration => {check_in:"2020-12-24 03:23 AM",check_out:"2020-12-26 03:23 AM"}}
            delete "/session" #signout user
            post  "/session", :params => {email: @userAdmin.email, password: "123456"}
            
            registation_id = Registration.where(user_id: "#{@user.id}").ids

            patch "/books/1/registrations/#{registation_id[0]}", :params => {:registration => {check_in: "2020-12-24 03:23 AM",check_out: "2020-12-26 03:23 AM", is_checked_in: true}}
            delete "/session" #signout admin user
            post  "/session", :params => {email: @user.email, password: "123456"}
            delete "/books/#{registation_id[0]}/registrations/1"
            expect(Registration.where(user_id: "#{@user.id}").count).not_to equal(0)

        end
    end
end
