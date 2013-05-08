
#Upcoming Work

##Stories

* Story 1: calculate driving distance beween places with google maps 
	* when editing route update distance (in progress)
	* automatically calculate distance when route is built
	* notify user when a route distance could not be computed
	* help user update name/location of places to find a route in google maps
* Story 2: update arrival date & nights automatically for all Places affected
	* when a place is modified or moved, re-ordered
	* highlight changes to make them visible to the user
* Story 3: Handle Destination deletion better
	* inactivate the Destination and its Excursions
	* Allow user to commit both deletion of Destination and Routes
* Story 4: User registration (devise)
* Story 5: Improve creation of forms (formtastic)

## Known Bugs
1. Places appear to be unique per user not trip; should be unique per trip.
	* tried adding "Columbus, OH" to trip "testing pickles" reported "name taken".  This names appears under the TGA2 trip.

#Release Notes

###Iteration 0.5 (Current)
* (Story1) Add basic support for getting driving distance

###Iteration 0.4
* Site is now usable for building a basic trip:
	* places can be re-ordered @done
	* routes get rebuilt automatically @done
	* support for arrival_date and number of nights @done

###Iteration 0.3
* __Views__
	* improve linking between trips, routes, way_places, places, and activities to make site usable @done

###Iteration 0.2 
* __Authentication__

* __Model__
	* better validation of data access (people see their own data) @done

###Iteration 0.1 

* __Models__
    * create objects @done
    * add validation to each model @done
    * implement user creation (password -> password_digest) @done
    * create seed data @done
* __Trip_view__
    * show trip with routes, places, way_places in table
	* unit and functional tests
	* good seed data
	* some linking between different models



