module Api
    module V1
        class BooksController < ApplicationController
            include ActionController::HttpAuthentication::Token
            before_action :authenticate_user
            def index
                books = Book.avalibe_books
                starts = DateTime.now
                ends = starts + 7
                books_by_date = Book.registered_avalible_books_by_date(starts, ends)
            end
           
            def all_books
                books = Book.avalibe_books
                render json:{books: books}
            end    
            def show
                book = Book.find(params[:id])
                render json: book
            end 
             
        end
    end
end
