# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def save_check(text, status)
 if status
    puts text
  else
    raise "FAIL: did NOT #{text}"
  end
end

User.delete_all
ActivityType.delete_all
Activity.delete_all
Route.delete_all
Trip.delete_all
Place.delete_all
WayPlace.delete_all

u1 = User.new name: "ovi_dev",      password: "st3rk3s", password_confirmation: "st3rk3s"
u2 = User.new name: "public1_dev",  password: "st3rk3s", password_confirmation: "st3rk3s"
u3 = User.new name: "public2_dev",  password: "st3rk3s", password_confirmation: "st3rk3s"
save_check "Create users", u1.save && u2.save && u3.save

at_stay_h =   ActivityType.new activity_type: "Hotel"
at_stay_c =   ActivityType.new activity_type: "Camping"
at_stay_f =   ActivityType.new activity_type: "Stay with Friends"
at_see =      ActivityType.new activity_type: "Sightsee"
at_nada =     ActivityType.new activity_type: "Twittle thumbs"
at_friends =  ActivityType.new activity_type: "See friends"
save_check "Create ActivityTypes", at_stay_h.save && at_stay_c.save && at_stay_f.save && at_see.save && at_nada.save && at_friends.save

t1 = Trip.new name: "TGA2", description: \
  "Cross-country trip from Columbus to Seattle. Duration is approximately 6-7 weeks.\
  We will see family and friends along the way, and stop by some National Parks as well. \
  As for cities, we're interested in seeing Minneapolis. ", user_id: u1.id
save_check "Create trip 1", t1.save 

p1  = Place.new name: "83 E Longview"
p2w = Place.new name: "kansas plains"
p2  = Place.new name: "Kansas City"
save_check "Create first places", p1.save && p2w.save && p2.save

rt1 = Route.new trip_id: t1.id, start_place: p1.id, end_place: p2.id, distance: 650 
save_check "Create the first route", rt1.save

# things to do:
a1  = Activity.new name: "trip planning", activity_type: at_nada.id, cost: 0, place_id: p1.id
a2  = Activity.new name: "visit Brian and Tracey", activity_type: at_friends.id, cost: 0, place_id: p2.id
a3  = Activity.new name: "stay with Brian and Tracey", activity_type: at_stay_f.id, cost: 0, place_id: p2.id
a3b = Activity.new name: "view.. ahh.. the best.. with cows!", activity_type: at_see.id, cost: 0, place_id: p2w.id
save_check "Create activities for first places", a1.save && a2.save && a3.save && a3b.save

wp1 = WayPlace.new place_id: p2w.id, route_id: rt1.id
save_check "Saved first Wayplace", wp1.save

p3 = Place.new name: "Witchita"
p4 = Place.new name: "Tulsa"
save_check "Create places in witchita amd Tulsa", p3.save && p4.save

rt2 = Route.new trip_id: t1.id, start_place: p2.id, end_place: p3.id, distance: 745  
rt3 = Route.new trip_id: t1.id, start_place: p3.id, end_place: p4.id, distance: 435
save_check "Create routes for Witchita & Tulsa", rt2.save && rt3.save

a4 = Activity.new name: "visit Diana's brother", activity_type: at_friends.id, cost: 0, place_id: p3.id
a5 = Activity.new name: "stay with Diana's brother", activity_type: at_stay_f.id, cost: 0, place_id: p3.id
a6 = Activity.new name: "visit Diana's parents", activity_type: at_friends.id, cost: 0, place_id: p4.id
a7 = Activity.new name: "stay with Diana's parents", activity_type: at_stay_f.id, cost: 0, place_id: p4.id
save_check "Create Kansas activities", a4.save && a5.save && a6.save && a7.save

# Colorado
p5w = Place.new name: "on the way to Denver"
p5  = Place.new name: "Denver"
p6w = Place.new name: "Mount Evans"
p6  = Place.new name: "Rocky Mountain NP"
save_check "Create Colorado places", p5w.save && p5.save && p6w.save && p6.save 

rt4 = Route.new trip_id: t1.id, start_place: p4.id, end_place: p5.id, distance: 1030
rt5 = Route.new trip_id: t1.id, start_place: p5.id, end_place: p6.id, distance: 731  
save_check "Create Colorado and Utah routes", rt4.save && rt5.save

wp2 = WayPlace.new place_id: p5w.id, route_id: rt4.id
save_check "Create wayplace 2", wp2.save

a8  = Activity.new name: "see downtown Denver", activity_type: at_see.id, cost: 0, place_id: p5.id
a9  = Activity.new name: "Holiday Inn", activity_type: at_stay_h.id, cost: 70, place_id: p5w.id
a10 = Activity.new name: "Sleep Inn", activity_type: at_stay_h.id, cost: 50, place_id: p5.id
a11 = Activity.new name: "Denver Zoo", activity_type: at_see.id, cost: 25, place_id: p5.id
a12 = Activity.new name: "Museum of Colorado history", activity_type: at_see.id, cost: 15, place_id: p5w.id
a13 = Activity.new name: "Rocky Mountain NP", activity_type: at_see.id, cost: 20, place_id: p6.id
a14 = Activity.new name: "Camping - Rocky Mountain NP", activity_type: at_see.id, cost: 17, place_id: p6.id
a15 = Activity.new name: "see sunset", activity_type: at_see.id, cost: 0, place_id: p5w.id
save_check "Colorado activities", a8.save && a9.save && a10.save && a11.save && a12.save && a13.save && a14.save && a15.save

p7w = Place.new name: "way to Arches"
p7  = Place.new name: "Arches NP"
save_check "Create arches places", p7w.save && p7.save

rt5 = Route.new trip_id: t1.id, start_place: p6.id, end_place: p7.id, distance: 731
save_check "Create route to Arches", rt5.save

rt6 = Route.new trip_id: t1.id, start_place: p7.id, end_place: p1.id, distance: 731
save_check "Create route to home", rt6.save

wp3 = WayPlace.new place_id: p6w.id, route_id: rt5.id
wp4 = WayPlace.new place_id: p7w.id, route_id: rt6.id
save_check "saving wayplaces 3,4", wp3.save && wp4.save

a16 = Activity.new name: "drive through Glen Canyon", activity_type: at_see.id, cost: 0, place_id: p7w.id
a17 = Activity.new name: "Lake Powell", activity_type: at_see.id, cost: 0, place_id: p7w.id
a18 = Activity.new name: "Camping - Lake Tenting resort", activity_type: at_stay_c.id, cost: 14, place_id: p7w.id
a19 = Activity.new name: "Arches NP", activity_type: at_see.id, cost: 30, place_id: p7.id
a20 = Activity.new name: "Delicate Arch", activity_type: at_see.id, cost: 0, place_id: p7.id
a21 = Activity.new name: "Solid Arch", activity_type: at_see.id, cost: 0, place_id: p7w.id
a22 = Activity.new name: "Lonely Arch", activity_type: at_see.id, cost: 0, place_id: p7w.id
save_check "Create final activities", a16.save && a17.save && a18.save && a19.save && a20.save && a21.save && a22.save 



# minimal trip
trb = Trip.new name: "Disneyworld trip", description: "Visiting Orlando for the first time \
  so the children can have some fun.  Parents will be drinking at the bars while grandpa \
  (thanks grandpa!) entertains the little tikes.  We will also stop by Opasola to purchase \
  some chocolate.  Word is it's the best there.", user_id: u2.id
save_check "Create second trip", trb.save

pb1  = Place.new name: "123 Pipers Squeak Dr."
pb2w = Place.new name: "state line - crossed for the first time"
pb2  = Place.new name: "1 Disneyworld Way, Orlando, Florida"
save_check "Create pb places", pb1.save && pb2.save && pb2w.save

rtb1 = Route.new trip_id: trb.id, start_place: pb1.id, end_place: pb2.id, distance: 120
save_check "Create rtb route", rtb1.save

wpb1 = WayPlace.new route_id: rtb1.id, place_id: pb2w.id
save_check "Create wpb WayPlace",  wpb1.save

acb1 = Activity.new name: "see Disneyworld", activity_type: at_see.id, cost: 1500
save_check "Create activity at destination", acb1.save






