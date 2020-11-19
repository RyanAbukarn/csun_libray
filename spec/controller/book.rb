require 'rails_helper'

RSpec.describe "Books", type: :request do
    before(:each) do
        newBooks = build_list(:book,3)
        newBooks.each do |newBook|
            newBook.save
        end
    end
    describe "GET index" do
        it "assigns @books" do
            book = Book.avalibe_books
            get :index
            expect(assigns(:books)).to eq(book) #@books
        end
        it "renders the index template" do
            get "http://127.0.0.1:3000/books"
            expect(response).to render_template("index")
        end
    end
end