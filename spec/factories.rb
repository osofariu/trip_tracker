
FactoryGirl.define do 
  factory :place do
    association :trip
    sequence(:name) {|i| "Place#{i}" }
    notes "PlaceNotes"
  end
end


FactoryGirl.define do 
  factory :trip do
    association :user
    sequence(:name) {|i| "TripName#{i}"}
    description "TripDescription"
  end
end


FactoryGirl.define do 
  factory :user do
    sequence(:name) {|i| "User#{i}"}
    password "st3rk3ts"
  end
end
