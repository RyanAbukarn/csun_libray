FactoryBot.define do 
    factory :registration do
        check_in { Date.today }
        check_out { check_in + 1 }
        after(:build) do |registration, evaluator|
            registration.user = create(:user)
            registration.book = create(:book)
        end
    end
    trait :with_books do
        transient do
          user {create(:user)} 
          book {create(:user)}
        end         
        after(:build) do |registration, evaluator|
            registration.user = evaluator.user
            registration.book = evaluator.book
        end
    end
end