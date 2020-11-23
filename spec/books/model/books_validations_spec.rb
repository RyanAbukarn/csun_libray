require 'rails_helper'

RSpec.describe Book do
    let(:book) { FactoryBot.build :book }
    describe "attributes" do
        it "has a name" do
            expect(book).to respond_to(:name)
        end 
    end
    describe "Book list" do
        it "returns all avalibe books" do
            newBooks = create_list(:book,3)
            expect(Book.avalibe_books).to match_array(newBooks)
        end
        it "returns no avalibe books" do
            newBookings = create_list(:registration,3,is_checked_in: true)
            expect(Book.avalibe_books).to match_array([])
        end
        it "returns all book by date" do
            newBookings = create_list(:registration,3)

            book = Book.registered_avalible_books_by_date(Date.today+2,Date.today+3).count
            expect(book).to equal(3)
            book = Book.registered_avalible_books_by_date(Date.today-3,Date.today-2).count
            expect(book).to equal(3)
            book = Book.registered_avalible_books_by_date(Date.today,Date.today+1).count
            expect(book).to equal(0)
        end
    end
    context "validations" do
        it "is not a valid ISBN because the lenght that is less than 13" do
            book.isbn = "1234567890" # length 10
            expect(book).not_to be_valid
        end

        it "is not valid a name becuase the lenght that is less than 3" do
            book.author = "ab" # length 2
            expect(book).not_to be_valid
        end

        it "is not valid a describtion becuase the lenght that is less than 15" do
            book.describtion = "12345678901234" # length 14
            expect(book).not_to be_valid
        end
        it "is not valid with empty attributes" do
            newBook = Book.new(
                name: nil,
                author: nil,
                isbn: nil, 
                describtion: nil)
            expect(newBook).not_to be_valid 
        end
    end
end


