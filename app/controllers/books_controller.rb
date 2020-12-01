require 'date'

class BooksController < ApplicationController
    before_action :require_signin , except: [:index, :show,:by_date,:by_date_new]
    before_action :require_admin, only: [:all_books,:create,:edit,:update,:destroy]

    def index
        @books = Book.avalibe_books
        @starts = DateTime.now
        @ends = @starts + 7
        @books_by_date = Book.registered_avalible_books_by_date(@starts, @ends)
    end
    def by_date
        @starts = DateTime.parse(params[:starts])
        @ends = DateTime.parse(params[:ends])
        if(@ends > @starts)
            @books_by_date = Book.registered_avalible_books_by_date(@starts, @ends)
            respond_to do |format|
                format.js
            end
        else
            redirect_to root_url, notice: "chick-in date is bigger than check-out date"
        end
    end

    def all_books
        @books = Book.all
        
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
        respond_to do |format|
            format.js
        end
    end
    
    def show
        @book = Book.find(params[:id])
    end

    private
        def book_perams
            params.require(:book).permit(:name,:author,:isbn,:describtion)
        end
end
