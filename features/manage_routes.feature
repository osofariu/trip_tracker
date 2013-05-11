Feature: Manage Routes

I want to see distance and driving time estimates for route

Background:
    Given I am logged in
    And   I have a trip
    And   My first destination named "Disneyworld, Orlando, FL", and a start date of "2013-07-10"
    And   Another destination named "Fort Myers, FL", an arrival date of "2013-07-15", and a duration of "7" nights

Scenario: I can see my first Route
    Then  I should see a Route from "Disneyworld, Orlando, FL" to "Fort Myers, FL" with no distance

@javascript
Scenario: I should be able to calculate distance, and see it with route on trip builder page
    When  I edit route the route
    And   I click button to Calculate the Route
    And   I click button to Update the Route
    Then  I should see a Route from "Disneyworld, Orlando, FL" to "Fort Myers, FL" with distance "183" and driving duration of "2 hours 46 minutes" 
