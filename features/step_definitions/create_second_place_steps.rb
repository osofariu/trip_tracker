

Given(/^I have a destination named "(.*?)", and set start date of "(.*?)"$/) do |arg1, arg2|
  @place1 = FactoryGirl.create(:place, trip_id: @trip.id, name: arg1, arrival_date: arg2)
end

When(/^I create a destination named "(.*?)", and set start date of "(.*?)", and duration of "(.*?)" days$/) do |arg1, arg2, arg3|
  click_link 'Build trip'
  click_link 'Add place'
  fill_in "Name", with: arg1
  place_date = Date.parse(arg2)
  select place_date.strftime("%Y"),  from: "place_arrival_date_1i"
  select place_date.strftime("%B"),  from: "place_arrival_date_2i"
  select place_date.strftime("%-d"), from: "place_arrival_date_3i"
  fill_in "Days", with: arg3
  click_button "Create Place"
end

Then(/^"(.*?)" should appear on the place builder plage with start date of "(.*?)", and duration of "(.*?)"$/) do |arg1, arg2, arg3|
  Place.where(name: arg1).first.should_not== nil
  page.has_content?(arg1).should == true
  page.has_content?(arg2).should == true
  page.has_content?(arg3).should == true
end
