Feature: Place management under the trip building page

So that I can manage my itinerary I need to see a list of Destinations, listed in 
the order in which they will be visited (a grey number will indicate the order), 
along with: the date when I arrive at each Destination, and how long I plan on visiting.

There should be links on the page that allow me to edit or delete each destination, 
as well a link that allows me to add new places at any point on the trip.

Scenario: Show destination name, arrival date, and how long I will be staying at the destination, on the place building page.
Given a Destination
When the Destination is named "Disney World", with arrival date of "2013-07-01", and the number of days set to "7"
Then I should see "Disney World", "Jul 1", "7 days" in the list of destinations.

