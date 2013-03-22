#MyTrip Application

## Entities

* Users (some have admin rights)
* Trips
* Places
* Routes
* Activities 
    * some are stop-overs - related to Routes
    * some are not stop-overs - related to Places

## Relations

* User has 0 or more Trips
* Trip has 0 or more Routes
* Route has 2 Places (start, end)
* Place has 0 or more Activities
* Route has 0 or more Activities (stop-overs)
* Activity

## Notes on Types

* Trip has optional ideal_start_date, ideal_end_date (used for display only)
* Trip has optional start_date, but the "actual_end_date is computed.
* Trip does not have start_place or end_place.. these are associated with Routes
    * If there's only one route these points define the outer-edges of the trip
    * If there are multiple routes, the last one's end_place is the final destination
    * For round-trips the start_place of the first route and the end_place of the last route must be the same.
* The routes are ordered, and the start_place of each route must be the same as the end_place of the next route.  This is enforced through business logic.
* The Activities associated with a Route may be considered special.. like "stop-overs"
* Places will be specialized (Lodging, Museum, etc.) but from the beginning we will just make that an enumerated list.
* Places will have name, description, cost.
* Activities will have name, description, cost.