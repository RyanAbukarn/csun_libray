require 'rails_helper'

RSpec.describe "Users", type: :model do
    let(:user) { FactoryBot.create :user }
    let(:book) { FactoryBot.create :book }
    subject { build(:user) }
    describe "belong to a user" do 
        it "check if a book belong to a user" do
            r = create(:registration, user: user, book: book)
            expect(r.user).to equal(user) 
            expect(r.book).to equal(book)
        end
    end
    context "validations" do
        
        it { should validate_presence_of(:fname) }
        it { should validate_length_of(:fname).is_at_least(3)}

        it { should validate_presence_of(:lname) }
        it { should validate_length_of(:lname).is_at_least(3)}

        it { should validate_presence_of(:email) }
        it { should_not allow_value("foo").for(:email) }
        it { should_not allow_value("foo@").for(:email) }

        it { is_expected.to allow_value("email@addresse.foo").for(:email) }

        it { should validate_presence_of(:phone) }
        it { should validate_length_of(:phone).is_equal_to(10)}

        it { should validate_presence_of(:password_digest) }
        it { should validate_length_of(:password_digest).is_at_least(6)}
        it { should have_secure_password() }

        it { should validate_presence_of(:address) }
        it { should validate_length_of(:address).is_at_least(5)}

        it { should validate_presence_of(:city) }

        it { should validate_presence_of(:state) }
        it { should validate_length_of(:state).is_equal_to(2)}

        it { should validate_uniqueness_of(:email) }
        it { should validate_length_of(:password_digest).is_at_least(6)}

      
        it "check if user in the system" do
            user.save
            User.auth(user.email,user.password_digest)
        end

        it "check if user not the system" do
            User.auth(user.email,user.password_digest) == false
        end
    end
    context "Relations" do
        it { should have_many(:registration) }
      end    
end
