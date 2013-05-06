Feature: Manage Destinations

	So that I can build my trip, I need to be able to create Destinations

Background:
    Given I am logged in
    And   I have a trip

Scenario: Create my first Destination
    When My first destination named "Disneyworld", and a start date of "2013-07-10"
	Then "Disneyworld" should appear on the Place Builder page with start date of "Jul 10"

Scenario: Create my second Destination - see default start_date same a first destination start date
    Given My first destination named "Disneyworld", and a start date of "2013-07-10"
    When  I go to create a new destination
    Then  On the form I should see arrival_date default to "2013", "July", "10"

Scenario: Create my second Destination - see it on trip builder page
    Given My first destination named "Disneyworld", and a start date of "2013-07-10"
	Given Another destination named "Fort Myers", an arrival date of "2013-07-15", and a duration of "7" nights
	Then "Fort Myers" should appear on the trip builder plage with start date of "Jul 15", and duration of "7 days"

Scenario: Create my third Destination - see arival_date with default set to second destination start date + duration
    Given My first destination named "Disneyworld", and a start date of "2013-07-10"
    Given Another destination named "Cape Canaveral", an arrival date of "2013-07-15", and a duration of "7" nights
    When  I go to create a new destination
    Then  On the form I should see arrival_date default to "2013", "July", "22"