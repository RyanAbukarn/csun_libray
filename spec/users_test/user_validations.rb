require 'rails_helper'

RSpec.describe User, :type => :request do
    let(:user) { FactoryBot.build :user }
    let(:book) { FactoryBot.build :book }

    let(:registration) {FactoryBot.build :registration}
    describe "belong to a user" do 
        it "check if a book belong to a user" do
            r = build(:registration,:with_books, user: user, book: book)
            r.user == user && r.book=book
        end
    end

    context "validations" do
        it "check the email format missing @" do
            user.email = "ryan-gmail.com"
            expect(user).not_to be_valid
        end
        it "check if user in the system" do
            user.save
            User.auth(user.email,user.password_digest)
        end

        it "check if user not the system" do
            User.auth(user.email,user.password_digest) == false
        end

        it "check if the user eamil is not been taken" do
            user.save
            sameEmail = build(:user,email: user.email)
            expect(sameEmail).not_to be_valid
        end
    
        it "is not valid fname and lname lenght that is less than 2" do
            user.fname = "a" # length 1 
            user.lname = "b" # length 1                       
            expect(user).not_to be_valid
        end

        it "is not a valid phone number lenght that is less than 10" do
            user.phone = "012345678" # length 1 
            expect(user).not_to be_valid
        end

        it "is not a valid address lenght should be atleate  5" do
            user.address = "1234" # length 4 
            expect(user).not_to be_valid
        end

        it "is not a valid state lenght should be 2" do
            user.address = "a" # length 1 
            expect(user).not_to be_valid
        end

        it "is not a valid password digest lenght should be at least 6 " do
            user.password_digest = "1234" # length 4
            expect(user).not_to be_valid
        end

        it "is not valid with empty attributes" do
            newUser = User.new(fname: nil,
                lname: nil,
                email: nil,
                phone: nil, 
                address: nil,
                city: nil,
                state: nil,
                password_digest: nil)
            expect(newUser).not_to be_valid 
        end
    end    
end
