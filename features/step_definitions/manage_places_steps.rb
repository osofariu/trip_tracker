
Given /My first destination named "(.*)", and a start date of "(.*)"/ do |name, start_date|
  click_link 'Create your first destination'
  fill_in "Name", with: name
  step("Fill select date \"arrival date\" with #{start_date}")
  click_button "Create Place"
end

Given /Another destination named "(.*)", an arrival date of "(.*)", and a duration of "(.*)" nights/ do |name, arrival_date, duration|
  within "#after_edit_parts" do
    click_link "Add place"
  end
  fill_in 'Name', with: name
  fill_in 'Nights', with: duration
  step("Fill select date \"arrival date\" with #{arrival_date}")
  click_button "Create Place"
end
When(/^I go to create a new destination$/) do
  first_place = @trip.places.first
  within "#after_edit_parts" do
    click_link "Add place"
  end
end

Given(/^I am logged in$/) do
  @user = create_user
  if login_for_user(@user.id)
    puts "User logged in as #{@user.name} (#{@user.id})"
  end
end

Given(/^I have a trip$/) do
  click_link "Create one?"
  fill_in "Name", with: "My first trip"
  fill_in "Description", with: "My first trip description"
  click_button "Save Trip"
  @trip=Trip.first
end

When(/^Fill select date (.*) with (.*)/) do |select_field, select_value|
  place_date = Date.parse(select_value)
  select place_date.strftime("%Y"),  from: "place_arrival_date_1i"
  select place_date.strftime("%B"),  from: "place_arrival_date_2i"
  select place_date.strftime("%-d"), from: "place_arrival_date_3i"
end

Then(/^"(.*?)" should appear on the Place Builder page with start date of "(.*?)"$/) do |arg1, arg2|
  page.has_content?(arg1).should == true
  page.has_content?(arg2).should == true
end

Then(/^"(.*?)" should appear on the trip builder plage with start date of "(.*?)", and duration of "(.*?)"$/) do |arg1, arg2, arg3|
  #save_and_open_page
  page.has_content?(arg1).should == true
  page.has_content?(arg2).should == true
  page.has_content?(arg3).should == true
end

Then(/^On the form I should see arrival_date default to "(.*?)", "(.*?)", "(.*?)"$/) do |arg1, arg2, arg3|
  find_field("place_arrival_date_1i").find('option[selected]').text.should == arg1
  find_field("place_arrival_date_2i").find('option[selected]').text.should == arg2
  find_field("place_arrival_date_3i").find('option[selected]').text.should == arg3  
end
