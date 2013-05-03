

Given(/^I have a destination named "(.*?)", and set start date of "(.*?)"$/) do |arg1, arg2|
  @place1 = FactoryGirl.create(:place, trip_id: @trip.id, name: arg1, arrival_date: arg2)
end

When(/^I create a destination named "(.*?)", with start date of:  "(.*?)"$/) do |arg1, arg2|
  save_page('/tmp/my_page2.html')
  click_link @trip.name
  click_link 'Places'
  save_page('/tmp/my_page3.html')
  click_link 'Add place'
  fill_in "Name", with: arg1
  place_date = Date.parse(arg2)
  select place_date.strftime("%Y"),  from: "place_arrival_date_1i"
  select place_date.strftime("%B"),  from: "place_arrival_date_2i"
  select place_date.strftime("%-d"), from: "place_arrival_date_3i"
  click_button "Create Place"
end

Then(/^"(.*?)" should appear on the place builder plage with start date of "(.*?)"$/) do |arg1, arg2|
  Place.where(name: arg1).first.should_not== nil
  page.has_content?(arg1).should == true
  page.has_content?(arg2).should == true
end
