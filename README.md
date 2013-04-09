
# TripTracker
* Simple application to help you plan a roadtrip.
* This application is still in its (early) infancy
* This is my first Rails app, so I expect I am doing lots of things wrong.

## Motivation
I am creating this application mainly to learn Rails (and Ruby), but I do want to make it functional. I wanted a simple web application for tracking roadtrips - create a basic itinerary, and track what happens when on that trip, day-by-day. 

###Questions
* I am not sure I am putting all the logic in the right place.. between view, helper, controller, and model.
	* Controller still messy, but I am still playing around with these.
	* I added some hacky routing by remembering in the session where I "came from" but it's messy and error-prone
* Would it help to add more associations between models using through: associations?
	* Associations are finally okay, but there's still some code out there that could be simplified with helpers.
* I need to separate data logically better so different users can't see others' data (previous one may address this too)
	* fixed.  Made the use the parent of the trip, and all data goes under that.


###Future Plans
* [isolate data exposure for controllers](https://github.com/voxdolo/decent_exposure)
* add Devise
* improve testing, use rspec.

## About This Application


### Model

* Users (some have admin rights)
* Trips
* Places
* Routes
* Activities 
    * some are stop-overs - related to Routes
    * some are not stop-overs - related to Places

### Model Relations

* User has 0 or more Trips
* Trip has 0 or more Routes
* Route has 2 Places (start, end)
* Place has 0 or more Activities
* Route has 0 or more Activities (stop-overs)
* Activity

### Notes on Model dependencies

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

