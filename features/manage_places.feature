Feature: Manage Destinations

	So that I can build my trip, I need to be able to create Destinations

Scenario: Create my first Destination

	Given I am logged in, and I have a trip
	When I create my first destination named "Disneyworld", and set start date to "2013-07-10"
	Then "Disneyworld" should appear on the Place Builder page with start date of "Jul 10"

Scenario: Create my second Destination

	Given I am logged in, and I have a trip
	Given I have a destination named "Disneyworld", and set start date of "2013-07-10"
    When  I create a destination named "Fort Myers", and set start date of "2013-07-15", and duration of "7" days
	Then "Fort Myers" should appear on the place builder plage with start date of "Jul 15", and duration of "7 days"

	