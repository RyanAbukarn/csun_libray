FactoryBot.define do 
  factory :book do
    sequence(:name) {|n| "book#{n}"}
    author {'Stephen King'}
    isbn {"1234567890123"}
    describtion {"The 
        true horror of the novel is how It turns the 
        innocence and joy of childhood against us,
        weaponizing the imaginations and goodness of kids "} 
  end
end