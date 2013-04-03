
#Dev Plan

## Model change
* what if I got rid of route / start_place and end_place?  Having this causes lots of issues with modeling relationships.
	* say.. continue to use direct relationship, but let the place track its association with the route..
	* a route could exist without a place in the DB or UI?
	* how efficient is it to always search for two places every time you show a route? - no less so
		* you already do that because you need more info!  It only helps with integrity..
	* I am bothered by the polymorphic relationship between route and place.. a place really belongs to 2 routes.
		* should I go through way_places and create two records - one as start and one as end? seems to be what I want when I show place relationships.
	
		* route id = 1								places: id = 1; id = 2, id = 3
			* route_place id = 1, type = start, place = 1
			* route_place id = 2, type = end, place = 2
			* route_place id = 3, type = way-place, place = 3

##QUESTIONS
* I am hard-coding fixure object it's so they can be reference from other objects. Is this ok?  Other ways to do this?
* I am not sure I am putting all the logic in the right place.. betwee view, helper, controller, and model.
* Would it help to add more associations between models using through: associations?
* I need to separate data logically better so different users can't see others' data (previous one may address this too)


##FUTURE
* [isolate data exposure for controllers](https://github.com/voxdolo/decent_exposure)


##NOW


###Iteration 0.3
* __Views__
	* improve linking between trips, routes, way_places, places, and activities to make site usable
***

###Iteration 0.2 @done
* __Authentication__
	* Add authentication
	* test authentication
* __Model__
	* better validation of data access (people see their own data)
***

###Iteration 0.1 @done

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

***


