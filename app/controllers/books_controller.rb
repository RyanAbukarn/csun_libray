require 'date'

class BooksController < ApplicationController
    before_action :require_signin , except: [:index, :show,:by_date,:by_date_new]
    before_action :require_admin, except: [:index, :show,:by_date,:by_date_new]

    def index
        @books= Book.avalibe_books
    end

    def new
        @book = Book.new
    end

    def by_date
        @start1 = covert_to_datetime(params[:start])
        @ends1  = covert_to_datetime(params[:ends])
        @books= Book.avalibe_books
        if(date_validation(@start1,@ends1))
            @book_by_date = Book.registered_avalible_books_by_date(@start1, @ends1)
        else
            redirect_to root_url, notice: "chick-in date is bigger than check-out date"
        end
    end

    def by_date_new
        redirect_to books_url
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

        def covert_to_datetime(paramDate)
            DateTime.new(paramDate['written_on(1i)'].to_i ,paramDate['written_on(2i)'].to_i, paramDate['written_on(3i)'].to_i, paramDate['written_on(4i)'].to_i, paramDate['written_on(5i)'].to_i)
        end
end
