#Dependency Mangement

Brainstorming notes

* I could use an observer to allow routes to notice a change in place sequences
	* when noticed, it would go through the current routes to make sure they reflect the order of places,
	* flag those that need to change (remember them)
	* apply changes
	* show user what was changed.

* How to do that
	* keep an array of routes that have been invalidated.. what gets removed
	* in the controller, update the routes list to include those removed ones, with a flag
	* also marked with a different flag those that were added.

	* since we are reacting to a single place change at the time, the most that will happen is:
		* two routes get deleted/modified for the old place
		* two routes get added/modified for the new place


####Before



	p1 		p2		p3 		p4 		p5
		r1		r2		r3		r4
 


#####Move p2 to (before) p5

 	p1 		p3 		p4		p2		p5
 		r1		r2		r3		r4



* All the routes change..

 	* the sequence number in the place practically define the route, but we still need something with info on the connection
	* what if route again has start and end places?


 	* Eliminate way_places completely, and allow routes to connect to place.
 		* if some one wants to stop someplace, they create a place
 		* but place could have a type too!  by default places are major stops that make up the route, but they could
 		also be minor .. such as a stop-over to see something.. like a water fall!
 			* place type is: minor -- it shows up on itinerary as an in-between-place.

 		* maybe use STI to handle this?  the seq_no gets busted with minor places?


Here's a concrete example:
	

	p1			p2			p3			p4			p5			p6
	
 		p11		   p21,p22		p31			p41
	
 	1	2		3	4	5	6	7		8	9		10			11
 	
 	^	-		^	-	-	^	-		^	-		^			^	


 * Moving a minor place around does NOT change any routes, but it will show up someplace else, on a different route
	* going through place, I can easily construct routes to show to the user,
 		and compare to those saved in the database

