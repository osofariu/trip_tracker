# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def save_check(text, *recs)
  if !recs or recs.size < 1
    raise "save_check missing arguments"
  end
  recs.each do |rec|
    if rec.save
      puts "Saved #{rec.class.name} value: #{rec.inspect}" 
    else
      puts "ERRORS saving #{rec.class.name}"
      p rec.errors
      raise "FAIL to save record" 
    end
  end
end

User.delete_all
ActivityType.delete_all
Activity.delete_all
Route.delete_all
Trip.delete_all
Place.delete_all

u1 = User.new name: "ovi_dev",   password: "st3rk3s", password_confirmation: "st3rk3s"
u2 = User.new name: "ovi_dev2",  password: "st3rk3s", password_confirmation: "st3rk3s"
u3 = User.new name: "ovi_dev3",  password: "st3rk3s", password_confirmation: "st3rk3s"
save_check "Create users", u1, u2, u3

at_stay_h =   ActivityType.new activity_type: "Hotel"
at_stay_c =   ActivityType.new activity_type: "Camping"
at_stay_f =   ActivityType.new activity_type: "Stay with Friends"
at_see =      ActivityType.new activity_type: "Sightsee"
at_nada =     ActivityType.new activity_type: "Twittle thumbs"
at_friends =  ActivityType.new activity_type: "See friends"
at_plan =     ActivityType.new activity_type: "Planning"
at_misc =     ActivityType.new activity_type: "Miscellaneous"
save_check "Create ActivityTypes", at_stay_h, at_stay_c, at_stay_f, at_see, at_nada, at_friends, at_plan, at_misc

t1 = Trip.new name: "TGA2", description: \
  "Cross-country trip from Columbus to Seattle. Duration is approximately 6-7 weeks.\
  We will see family and friends along the way, and stop by some National Parks as well. \
  As for cities, we're interested in seeing Minneapolis. ", user_id: u1.id
save_check "Create trip 1", t1

p1  = Place.new name: "E Longview", trip_id: t1.id
p2  = Place.new name: "Kansas City", trip_id: t1.id
save_check "Create first places", p1, p2

p2w = Place.new name: "kansas plains", trip_id: t1.id, parent_id: p2.id
save_check "Creating first minor place", p2w

# route 1
rt1 = Route.where(trip_id: t1.id, start_place_id: p1.id, end_place_id: p2.id).first
rt1.distance = 450
save_check "Create the first route", rt1

# things to do:
a1  = Activity.new name: "trip planning", activity_type: at_plan.id, cost: 0, place_id: p1.id
a1b = Activity.new name: "packing", activity_type: at_plan.id, cost: 0, place_id: p1.id
a1c = Activity.new name: "buying supplies", activity_type: at_plan.id, cost: 700, place_id: p1.id
a2  = Activity.new name: "visit Brian and Tracey", activity_type: at_friends.id, cost: 0, place_id: p2.id
a3  = Activity.new name: "stay with Brian and Tracey", activity_type: at_stay_f.id, cost: 0, place_id: p2.id
a3b = Activity.new name: "view.. ahh.. the best.. with cows!", activity_type: at_see.id, cost: 0, place_id: p2w.id
save_check "Create activities for first places", a1, a1b, a1c,a2, a3, a3b

p3 = Place.new name: "Witchita", trip_id: t1.id
p4 = Place.new name: "Tulsa", trip_id: t1.id
save_check "Create places in witchita and Tulsa", p3, p4

puts "Looking FOR route for trip #{t1.id} from #{p2.id} to #{p3.id}"
rt2 = Route.where(trip_id: t1.id, start_place_id: p2.id, end_place_id: p3.id).first
rt2.distance = 240
rt3 = Route.where(trip_id: t1.id, start_place_id: p3.id, end_place_id: p4.id).first
rt3.distance = 433
save_check "routes 2,3", rt2, rt3

a4 = Activity.new name: "visit Diana's brother", activity_type: at_friends.id, cost: 0, place_id: p3.id
a5 = Activity.new name: "stay with Diana's brother", activity_type: at_stay_f.id, cost: 0, place_id: p3.id
a6 = Activity.new name: "visit Diana's parents", activity_type: at_friends.id, cost: 0, place_id: p4.id
a7 = Activity.new name: "stay with Diana's parents", activity_type: at_stay_f.id, cost: 0, place_id: p4.id
save_check "Create Kansas activities", a4, a5, a6, a7

# Colorado
p5  = Place.new name: "Denver", trip_id: t1.id
p6  = Place.new name: "Rocky Mountain NP", trip_id: t1.id
save_check "Create Colorado places", p5, p6 

p5w = Place.new name: "on the way to Denver", trip_id: t1.id, parent_id: p5.id 
p6w = Place.new name: "Mount Evans", trip_id: t1.id, parent_id: p5.id
save_check "Create Colorado minor places", p5w, p6w

rt4 = Route.where(trip_id: t1.id, start_place_id: p4.id, end_place_id: p5.id).first
rt4.distance=1030

rt5 = Route.where(trip_id: t1.id, start_place_id: p5.id, end_place_id: p6.id).first
rt5.distance = 731
save_check "Create Colorado and Utah routes", rt4, rt5

a8  = Activity.new name: "see downtown Denver", activity_type: at_see.id, cost: 0, place_id: p5.id
a9  = Activity.new name: "Holiday Inn", activity_type: at_stay_h.id, cost: 70, place_id: p5w.id
a10 = Activity.new name: "Sleep Inn", activity_type: at_stay_h.id, cost: 50, place_id: p5.id
a11 = Activity.new name: "Denver Zoo", activity_type: at_see.id, cost: 25, place_id: p5.id
a12 = Activity.new name: "Museum of Colorado history", activity_type: at_see.id, cost: 15, place_id: p5w.id
a13 = Activity.new name: "Rocky Mountain NP", activity_type: at_see.id, cost: 20, place_id: p6.id
a14 = Activity.new name: "Camping - Rocky Mountain NP", activity_type: at_see.id, cost: 17, place_id: p6.id
a15 = Activity.new name: "see sunset", activity_type: at_see.id, cost: 0, place_id: p5w.id
a16w= Activity.new name: "Replace brakes", activity_type: at_misc.id, cost: 450, place_id: p6w.id
save_check "Colorado activities", a8, a9, a10, a11, a12, a13, a14, a15, a16w


p7  = Place.new name: "Arches NP", trip_id: t1.id
save_check "Create arches place", p7

p7w = Place.new name: "way to Arches", trip_id: t1.id, parent_id: p7.id
save_check "Create arches minor place", p7w

rt6 = Route.where(trip_id: t1.id, start_place_id: p6.id, end_place_id: p7.id).first
rt6.distance = 731

rt7 = Route.new(trip_id: t1.id, start_place_id: p7.id, end_place_id: p1.id)
rt7.distance = 1350
save_check "Create routes to Arches and home", rt6, rt7


a16 = Activity.new name: "drive through Glen Canyon", activity_type: at_see.id, cost: 0, place_id: p7w.id
a17 = Activity.new name: "Lake Powell", activity_type: at_see.id, cost: 0, place_id: p7w.id
a18 = Activity.new name: "Camping - Lake Tenting resort", activity_type: at_stay_c.id, cost: 14, place_id: p7w.id
a19 = Activity.new name: "Arches NP", activity_type: at_see.id, cost: 30, place_id: p7.id
a20 = Activity.new name: "Delicate Arch", activity_type: at_see.id, cost: 0, place_id: p7.id
a21 = Activity.new name: "Solid Arch", activity_type: at_see.id, cost: 0, place_id: p7w.id
a22 = Activity.new name: "Lonely Arch", activity_type: at_see.id, cost: 0, place_id: p7w.id
save_check "Create final activities", a16, a17, a18, a19, a20, a21, a22 

# minimal trip
trb = Trip.new name: "Disneyworld trip", description: "Visiting Orlando for the first time \
  so the children can have some fun.  Parents will be drinking at the bars while grandpa \
  (thanks grandpa!) entertains the little tikes.  We will also stop by Opasola to purchase \
  some chocolate.  Word is it's the best there.", user_id: u2.id
save_check "Create second trip", trb

pb1  = Place.new name: "123 Pipers Squeak Dr.", trip_id: trb.id
pb2  = Place.new name: "1 Disneyworld Way, Orlando, Florida", trip_id: trb.id
save_check "Create pb places", pb1, pb2

pb2w = Place.new name: "state line - crossed for the first time", trip_id: trb.id, parent_id: pb1.id
save_check "Create pb places", pb2w

rtb1 = Route.where(trip_id: trb.id, start_place_id: pb1.id, end_place_id: pb2.id).first
rtb1.distance = 320
save_check "Create rtb route", rtb1

acb1 = Activity.new name: "see Disneyworld", activity_type: at_see.id, cost: 1500, place_id: pb2.id
acb2 = Activity.new name: "take pictures", activity_type: at_see.id, cost: 5, place_id: pb2w.id
save_check "Create activity at destination", acb1, acb2






