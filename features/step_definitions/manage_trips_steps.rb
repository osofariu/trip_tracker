Given(/^I don't have any trips$/) do
end

Then(/^I should be notified that I don't have any trips$/) do
  page.has_content?('You don\'t have any trips.').should == true
end

Then(/^I should be given the opportunity to create one$/) do
  page.has_link?('Create one?').should == true
end