FactoryGirl.define do 
  factory :user do
    sequence(:name) {|i| "User#{i}"}
    password "st3rk3ts"
  end

  factory :trip do
    user
    sequence(:name) {|i| "Trip#{i}"}
    description "I am going to Disneyworld"
  end

  factory :place do
    trip
    sequence(:name) {|i| "Place#{i}" }
    notes "This is a nice place. I mean, niiiice"
  end
end
