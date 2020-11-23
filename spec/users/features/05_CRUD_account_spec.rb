require 'rails_helper'


RSpec.describe "deleting account" do
    feature 'user deletes his/her own account' do
        before(:each) do
            @user1 = create(:user)
            @user2 = create(:user)
            visit "session/new"
            longin(@user1)
        end
        scenario 'Right user' do
            visit @user2.id
            expect(page).not_to have_content("Delete Account")
            expect(page).not_to have_content("Edit Account")
        end
        scenario 'Deleting the account',js: true  do
            accept_confirm do
                click_link("Delete Account")
            end
            expect(page).to have_content("Account successfully deleted!")
        end
        scenario 'Editing the account',js: true  do
            click_link("Edit Account")
            fill_in "user_fname",	with: "new name"
            fill_in "user_lname", with: "new last"
            fill_in "user_email",	with: @user1.email
            fill_in "user_phone",	with: @user1.phone
            fill_in "user_address",	with: @user1.address
            fill_in "user_password", with: "123456"
            select 'California', from: 'user_state'
            select 'San Diego', from: 'user_city'
            click_button("Submit")
            expect(page).to have_content("Account successfully updated!")
        end
    end
    
end

def longin(user)
    fill_in "email",	with: user.email
    fill_in "password", with: "123456"
    click_button("login")
end