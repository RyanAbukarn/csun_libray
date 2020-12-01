require 'rails_helper'
RSpec.describe "CRUD Books" do
    feature 'CRUD for admin users' do
        before(:each) do
            @book = create_list(:book,1)
            @user = create(:user, admin: true)
            visit '/all_books'

            longin(@user)
        end
        scenario 'Editing a book' do
            click_link("Edit")
            fill_in "book_name" ,with: "this book loves you"
            click_button("Submit")
            expect(page).to have_content("Book successfully updated!")
        end
        scenario 'Adding a book' do
            beforeAdding = Book.all.count
            click_link("Dashborad")
            click_link("Add new books")
            fill_in "book_name" ,with: "this book loves you"
            fill_in "book_author" ,with: "stephen king"
            fill_in "book_isbn" ,with: "0123456789123"
            fill_in "book_describtion" ,with: "this book loves so much you dont be"
            click_button("Submit")
            AfterAdding  = Book.all.count
            expect(page).to have_content("Book successfully created!")
            expect(AfterAdding).not_to equal(beforeAdding)

        end
        scenario 'Deleting a book', js: true do
            accept_confirm do
                click_link("Delete")
            end
            expect(page).to have_content(@book[0].name)
        end
        scenario 'accessing all books' do
            booked_books = create_list(:registration,3,is_checked_in: true)
            visit '/all_books'

            expect(page).to have_content(booked_books[0].book.name)
            expect(page).to have_content(booked_books[1].book.name)
            expect(page).to have_content(booked_books[2].book.name)

        end
    end
    feature 'CRUD for NOT admin users' do
        before(:each) do
            @booked_books = create_list(:registration,3,is_checked_in: true)
            @user = create(:user)
            
            visit '/all_books'

            longin(@user)
            
        end
        scenario 'accessing all books' do
            expect(page).not_to have_content(@booked_books[0].book.name)
            expect(page).not_to have_content(@booked_books[1].book.name)
            expect(page).not_to have_content(@booked_books[2].book.name)

        end
    end
end

def longin(user)
    fill_in "email",	with: user.email
    fill_in "password", with: "123456"
    click_button("login")
end

