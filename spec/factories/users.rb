FactoryBot.define do 
    factory :user do
      sequence(:fname) {|n| "fname#{n}"}
      sequence(:lname) {|n| "lname#{n}"}
      email {"#{fname}_#{lname}@csun.edun"}
      phone {"1234567890"}
      address {"1111 usa"}
      city {"Thousand Oaks"}
      state {"CA"}
      password_digest {BCrypt::Password.create("123456")}
    end
end