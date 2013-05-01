
FactoryGirl.define do 
  factory :trip do
    association :user
    sequence(:name) {|i| "TripName#{i}"}
    description "TripDescription"
  end
end