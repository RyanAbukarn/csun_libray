require 'rails_helper'
RSpec.describe "CRUD Books" do
    feature 'CRUD for admin users' do
        before(:each) do
            @book = create(:book)
            @user = create(:user, admin: true)
            visit '/all_books'
            login
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
            expect(page).not_to have_content(@book.name)
        end
        scenario 'accessing all books' do
            booked_books = create_list(:registration,3,:booked_for_a_whole_week)
            visit '/all_books'
            expect(page).to have_content(booked_books[0].book.name)
            expect(page).to have_content(booked_books[1].book.name)
            expect(page).to have_content(booked_books[2].book.name)

        end
    end
    feature 'CRUD for NOT admin users' do
        before(:each) do 
            @user = create(:user)
            @book = create_list(:registration,3,:booked_for_a_whole_week) 
            visit '/'
        end
        scenario 'viewing booked books' do
            expect(page).to have_content(@book[0].book.name)
            expect(page).to have_content(@book[1].book.name)
            expect(page).to have_content(@book[2].book.name)
        end
        scenario 'not viewing all books', focus: true do
            click_link("Log In")
            login
            visit '/all_books'
            expect(page).to have_content("Search by date")
        end
    end
end

def login
    fill_in "email",	with: @user.email
    fill_in "password", with: "123456"
    click_button("login")
end

