Given(/^I am on the login page$/) do
    visit 'http://localhost:3000/login'
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  page.fill_in "Traveler Name:", with: arg1
  page.fill_in "Traveler Password:", with: arg2
end

When(/^I press "(.*?)"$/) do |arg1|
  click_button "Login"
end

Then(/^I should be on home page$/) do
  #if page.has_content?("Welcome to Trip Tracker")
  #  puts "Welcome"
  #end
end

Then(/^I should see "(.*?)"$/) do |arg1|
  if page.has_content?('You are logged in as ovi_dev')
    puts "Logged in"
  end
end