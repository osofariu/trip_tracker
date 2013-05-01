
FactoryGirl.define do 
  factory :place do
    association :trip
    sequence(:name) {|i| "Place#{i}" }
    notes "PlaceNotes"
  end
end

