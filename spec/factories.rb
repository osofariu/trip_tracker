
FactoryGirl.define do 
  factory :place do
    association :trip
    sequence(:name) {|i| "Place#{i}" }
    notes "This is a nice place. I mean, niiiice"
  end
end


FactoryGirl.define do 
  factory :trip do
    association :user
    sequence(:name) {|i| "Trip#{i}"}
    description "I am going to Disneyworld"
  end
end


FactoryGirl.define do 
  factory :user do
    sequence(:name) {|i| "User#{i}"}
    password "st3rk3ts"
  end
end
