
#Dev Plan

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


