require 'rails_helper'

RSpec.describe "Books", type: :model do
    subject { build(:book) }

   
    describe "Book list" do
        it "returns all avalibe books" do
            newBooks = create_list(:book,3)
            expect(Book.avalibe_books).to match_array(newBooks)
        end
        it "returns no avalibe books" do
            expect(Book.avalibe_books).to match_array([])
        end
        # working on it 
        it "returns all book by date" do
            newBookings = create_list(:registration,3).count
            book = Book.registered_avalible_books_by_date(Date.today+2,Date.today+3)
            expect(book).to match_array(newBookings)
            book = Book.registered_avalible_books_by_date(Date.today-3,Date.today-2)
            expect(book).to match_array(newBookings)
            book = Book.registered_avalible_books_by_date(Date.today,Date.today+1)
            expect(book).to match_array(newBookings)
        end
    end
    context "validations" do
        it { should validate_presence_of(:name) }
        it { should validate_length_of(:name).is_at_least(3)}

        it { should validate_presence_of(:author) }
        it { should validate_length_of(:author).is_at_least(3)}

        it { should validate_presence_of(:isbn) }
        it { should validate_length_of(:isbn).is_equal_to(13)}


        it { should validate_presence_of(:describtion) }
        it { should validate_length_of(:describtion).is_at_least(15)}

    end
    context "Relations" do
      it { should have_many(:registration) }
    end
end


