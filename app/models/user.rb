class User < ApplicationRecord
    has_many :registration, dependent: :destroy
    has_secure_password
    validates :fname, :lname, :email, :phone, :address, :city, :state, :password_digest , presence: true
    validates :fname, length: {minimum: 3}
    validates :phone, length: {is: 10}
    validates :address, length: {minimum: 5}
    validates :state, length: {is: 2}
    validates :password_digest, length: {minimum: 6}

    validates :email, format: {
        with: URI::MailTo::EMAIL_REGEXP,
        message: "Must be word@word.word"
    }


    def self.auth(email,password)
        @user = User.find_by_email(email)
        @user && @user.authenticate(password)
    end


end
