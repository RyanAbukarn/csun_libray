require 'rails_helper'

feature 'login page: validate page element' do
    background do
        newBooks = build_list(:book,1)
        newBooks.each do |newBook|
            newBook.save
        end
        visit '/'
    end

    scenario 'Login first to rent a book' do
        rentAbook
        expect(page).to have_content("book successfully booked!")
    end

    scenario 'Canceling booking' do
        user = rentAbook
        click_link("#{user.fname}")
        accept_alert do
            click_link('Cancel Order')
        end
    end

end
def longin
    user = create(:user)
    fill_in "email",	with: user.email
    fill_in "password", with: "123456"
    click_button("login")
    user 
end
def rentAbook
    click_link("Rent")
    user = longin
    select "18", from: "registration_check_in_3i"
    select "20", from: "registration_check_out_3i"
    click_button("Submit")
    user
end 
