class Registration < ApplicationRecord
  belongs_to :book
  belongs_to :user
  
  def self.is_available_to_rent(book_id,start,ends)
    !Registration.where("book_id=#{book_id} and check_in ='#{start}' or check_out='#{ends}'").any?
  end
  
end
