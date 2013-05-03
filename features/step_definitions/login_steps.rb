Given(/^I am on the login page$/) do
    visit 'http://localhost:3000/login'
end

When(/^I fill in Traveler Name: with "(.*?)" and password with "(.*?)"$/) do |arg1, arg2|
  @user = FactoryGirl.build(:user)
  @user.name=arg1
  @user.password=arg2
  @user.save
  page.fill_in "Traveler Name:", with: @user.name
  page.fill_in "Traveler Password:", with: @user.password
end

When(/^I press "(.*?)"$/) do |arg1|
  click_button "Login"
  u=User.all
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.has_content?("You are logged in as #{@user.name}").should == true
end