Feature: Manage Users

	As a sentient being who is able to use a computer
	and who wants to plan a roadtrip, I should be able
	to sign up to become a user of TripTracker, and
	subsequently log in as that user.

	Scenario: Log in
		Given  I am not logged in yet
        When   I log in
        Then   I should see the Welcome page   