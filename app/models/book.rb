class Book < ApplicationRecord
    has_many :registration, dependent: :destroy
    validates :name, :author,:isbn,:describtion, presence: true
    validates :name, :author, length: {minimum: 3}
    validates :isbn, length: {is: 12 }
    validates :describtion,length: {minimum: 15}
end
