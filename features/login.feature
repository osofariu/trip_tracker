Feature: Authentication
	In Order to see my welcome page and use the application
	as a member I should login successfully

	Scenario:Successful Login
		Given I am on the login page
		When I fill in Traveler Name: with "John Doer" and password with "st3rk3sst3rk3s"
		And I press "Sign in"
		Then I should see "You are logged in as John Doer"

