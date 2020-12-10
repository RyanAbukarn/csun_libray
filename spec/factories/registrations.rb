FactoryBot.define do 
    factory :registration do
        check_in { Date.today }
        check_out { check_in + 1 }
        is_checked_in {false}

        user {create(:user)}
        book {create(:book)}
        trait :booked_for_a_whole_week do
            check_in { DateTime.now - 4 }
            check_out { check_in + 1}
            is_checked_in {true}
        end
    end    
end