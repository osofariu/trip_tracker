Given(/^I am logged in, and I have a trip$/) do
  @user = create_user1
  @trip = FactoryGirl.create(:trip, user_id: @user.id)
  if login_for_user(@user.id)
    puts "User logged in as #{@user.name}"
  end
end

When(/^I create a destination named "(.*?)", and set start date of "(.*?)"$/) do |arg1, arg2|
  click_link @trip.name
  click_link 'Places'
  click_link "Create your first destination"
  fill_in "Name", with: arg1
  place_date = Date.parse(arg2)
  select place_date.strftime("%Y"),  from: "place_arrival_date_1i"
  select place_date.strftime("%B"),  from: "place_arrival_date_2i"
  select place_date.strftime("%-d"), from: "place_arrival_date_3i"
  click_button "Create Place"
  save_page('/tmp/my_page.html')
end

Then(/^"(.*?)" should appear on the Place Builder page with start date of "(.*?)"$/) do |arg1, arg2|
  Place.where(name: arg1).first.should_not== nil
  page.has_content?(arg1).should == true
  page.has_content?(arg2).should == true
end