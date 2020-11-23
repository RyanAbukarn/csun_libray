require 'rails_helper'
RSpec.describe "login and logout" do
    feature 'login page: validate page element' do
        before(:each) do
            @user = create(:user)
            visit 'session/new'
        end

        scenario 'login with vaild username/password' do
            fill_in "email",	with: @user.email
            fill_in "password", with: "123456"
            click_button("login")
            expect(page).to have_content("Edit Account")
        end
        scenario 'login with invaild password' do
            fill_in "email",	with: @user.email
            fill_in "password", with: "1"
            click_button("login")
            expect(page).to have_content("Log In")
        end
        scenario 'login with invaild username' do
            fill_in "email",	with: "someone"
            fill_in "password", with: @user.password
            click_button("login")
            expect(page).to have_content("Log In")
        end
        scenario 'login then logout' do
            fill_in "email",	with: @user.email
            fill_in "password", with: "123456"
            click_button("login")
            click_link("Sign Out")
            expect(page).to have_content("Log In")
        end
    end
end