class BooksController < ApplicationController
    #before_action :show_available_books
    before_action :require_signin , except: [:index, :show]
    before_action :require_admin, except: [:index, :show]
    def index
        @books= Book.all
    end
    def new
        @book = Book.new 
    end

    def edit
        @book = Book.find(params[:id])
    end 

    def update
        @book = Book.find(params[:id])
        if @book.update(book_perams)
            redirect_to @book, notice: "Book successfully updated!" 
        else
            render :edit
        end
    end
    def create
        @book = Book.new(book_perams)
        if @book.save
            redirect_to @book, notice: "Book successfully created!" 
        else
            render :new
        end
    end
    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_url, notice: "Book successfully deleted!"
    end
    def show
        @book = Book.find(params[:id])
    end
private
    def book_perams
        params.require(:book).permit(:name,:author,:isbn,:describtion)
    end 


end
