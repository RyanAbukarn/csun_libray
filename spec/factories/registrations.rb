FactoryBot.define do 
    factory :registration do
        check_in { Date.today }
        check_out { check_in + 1 }
        is_checked_in {false}
        user {create(:user)}
        book {create(:book)}
    end    
end