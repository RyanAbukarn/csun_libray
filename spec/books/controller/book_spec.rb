require 'rails_helper'

RSpec.describe BooksController, type: :request do
    before(:each) do
        @userAdmin = create(:user,admin: true)
        @user = create(:user)
        @books1 = create_list(:book,2)
    end

    context "when the user is admin" do
        it "will delete a book" do
            post  "/session", :params => {email: @userAdmin.email, password: "123456"}
            delete "/books/#{@books1[0].id}"
            expect(Book.all.count).to eq(@books1.count - 1) 
        end
        it "will create a book" do
            post  "/session", :params => {email: @userAdmin.email, password: "123456"}
            newBook = build(:book)
            post "/books", :params => {book: {name: newBook.name, author: newBook.author, isbn: newBook.isbn, describtion:newBook.describtion}} 
            expect(Book.all.count).to eq(@books1.count + 1) 
        end
        it "assigns @books" do
            book = Book.avalibe_books
            get "/books"
            expect(response).to render_template(:index)
            #@books = assigns(:books)
            expect(assigns(:books)).to eq(book) 
        end
    end
    
    context "when the user is not admin" do
        it "will not delete a book " do
            post  "/session", :params => {email: @user.email, password: "123456"}
            delete "/books/#{@books1[0].id}"
            expect(Book.all).to eq(@books1) #@books = assigns(:books)
        end
        it "will not create a book" do
            newBook = build(:book)
            post "/books", :params => {book: {name: newBook.name, author: newBook.author, isbn: newBook.isbn, describtion:newBook.describtion}} 
            expect(Book.all.count).to eq(@books1.count) #@books = assigns(:books)
        end
    end
end
