
Given(/^a Destination$/) do
  @destination = Place.new
end

When(/^the Destination is named "(.*?)", with arrival date of "(.*?)", and the number of days set to "(\d+)"$/) do |arg1, arg2, arg3|
  @destination.name=arg1
  @destination.arrival_date=arg2
  @destination.days=arg3
end

Then(/^I should see "(.*?)", "(.*?)", "(.*?)" in the list of destinations\.$/) do |arg1, arg2, arg3|
  @destination.name.should == arg1
  @destination.showArrivalDate.should == arg2
  @destination.showDuration.should == arg3
end
