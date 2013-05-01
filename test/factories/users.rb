
FactoryGirl.define do 
  factory :user do
    sequence(:name) {|i| "User#{i}"}
    password "st3rk3ts"
  end
end