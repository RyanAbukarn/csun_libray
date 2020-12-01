class Book < ApplicationRecord
    has_many :registration, dependent: :destroy
    validates :name, :author,:isbn,:describtion, presence: true
    validates :name, :author, length: {minimum: 3}
    validates :isbn, length: {is: 13 }
    validates :describtion,length: {minimum: 15}

    scope :avalibe_books, -> { 
        joins("left outer join registrations on registrations.book_id = books.id").where(:registrations => {:id=>nil})
    }
    def self.registered_avalible_books_by_date(start,ends)
        joins(:registration).where.not('check_in BETWEEN ? AND ?', start.beginning_of_day, ends.end_of_day).group(:book_id)
    end
    
end
