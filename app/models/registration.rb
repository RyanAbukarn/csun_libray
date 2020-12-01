class Registration < ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :check_in, :check_out, presence: true
  validate :end_date_after_start_date
  def start_time
    self.check_in
  end
  def end_time
    self.check_out
  end
 
  private

    def end_date_after_start_date
      return if check_out.blank? || check_in.blank?

      if check_out < check_in
        errors.add(:check_out, "must be after the start date")
      end
    end
    
    def self.is_available_to_rent(book_id,start,ends)
      !Registration.where("book_id=#{book_id} and check_in ='#{start}' or check_out='#{ends}'").any?
    end
    def self.registred_books
      Registration.all.where(is_checked_out: false)
    end
end
