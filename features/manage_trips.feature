Feature: Manage Trips

	So that I can travel, as a user of the system I can create one or more trips.

Scenario: I don't have any trips
	Given 	I don't have any trips
	When 	I log in
	Then    I should be notified that I don't have any trips
	And     I should be given the opportunity to create one
