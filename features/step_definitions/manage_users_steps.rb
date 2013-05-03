
Given(/^I am not logged in yet$/) do
  visit 'http://localhost:3000/'
  page.has_content?('You are not logged in').should == true
end

When(/^I log in$/) do
  @user = create_user1
  if login_for_user(@user.id)
    puts "User logged in as #{@user.name}"
  end
end

Then(/^I should see the Welcome page$/) do
  page.has_content?("You are logged in as #{@user.name}").should == true
end
