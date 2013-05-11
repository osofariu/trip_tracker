Then(/^I should see a Route from "(.*?)" to "(.*?)" with distance "(.*?)" and driving duration of "(.*?)"$/) do |arg1, arg2, arg3, arg4|
  #save_and_open_page
  within_table('routes_list_table') do
    has_content?(arg1).should == true
    has_content?(arg2).should == true
    has_content?(arg3).should == true
    has_content?(arg4).should == true
  end
end

Then(/^I should see a Route from "(.*?)" to "(.*?)" with no distance$/) do |arg1, arg2|
    within_table('routes_list_table') do
      has_content?(arg1).should == true
      has_content?(arg2).should == true
    end
end

When(/^I edit route the route$/) do
  @route=@user.trips.first.routes.first
  click_link "rt#{@trip.id}-#{@route.id}"
end

When(/^I click button to Calculate the Route$/) do
  click_button 'Lookup route info'
end

When(/^I click button to Update the Route$/) do
  click_button 'Update Route'
end
