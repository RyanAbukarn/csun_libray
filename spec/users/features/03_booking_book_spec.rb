require 'rails_helper'
RSpec.describe "booking books" do
    feature 'for normal users' do
        before(:each) do
            create(:book)
            @user = create(:user)
            visit '/'
        end
        scenario 'Login first to rent a book' do

            rentAbook
            expect(page).to have_content("book successfully booked!")

        end
        scenario 'Canceling order', js: true do
            rentAbook
            click_link("#{@user.fname}")
            accept_confirm do
                click_button('Cancel Order')
            end
            expect(page).to have_content("Order is successfully canceled!")

        end
    end
    feature 'For admin user' do
        before(:each) do
            @registration = create(:registration)
            @user = create(:user,admin: true)
            visit '/'
            click_link("Log In")
            login
            visit '/all_users'
            
        end
        scenario 'User took the book and returned it' do
            click_link("Edit")
            choose('registration_is_checked_in_true')
            click_button("Submit")

            expect(page).to have_content("updated successfully")
            visit '/all_users'
            click_link("Edit")
            expect(page).not_to have_content("Did user take the book")
            choose('registration_is_checked_out_true')
            click_button("Submit")

            expect(page).to have_content("The book is available")
            expect(page).to have_content("#{@registration.book.name}")
            expect(page).to have_content("#{@registration.book.isbn}")
        end
        
    end
end

def login
    fill_in "email",	with: @user.email
    fill_in "password", with: "123456"
    click_button("login")
end
def rentAbook
    click_link("Rent")
    login
    select "3" , from: "registration_check_in_3i"
    select "5" , from: "registration_check_out_3i"
    click_button("Submit")
end 
