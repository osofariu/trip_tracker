# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
ActivityType.delete_all
Activity.delete_all
Route.delete_all
Trip.delete_all
Place.delete_all
WayPlace.delete_all

ActivityType.create activity_type: "Hotel"
ActivityType.create activity_type: "Camping"
ActivityType.create activity_type: "Sightsee"
ActivityType.create activity_type: "Twittle thumbs"
ActivityType.create activity_type: "See friends"

at1 = ActivityType.where(activity_type: "Hotel").first
at2 = ActivityType.where(activity_type: "Camping").first
at3 = ActivityType.where(activity_type: "Sightsee").first
at5 = ActivityType.where(activity_type: "Twittle thumbs").first
at6 = ActivityType.where(activity_type: "See friends").first


User.create name: "tester1", password: "test123", password_confirmation: "test123"
User.create name: "tester2", password: "test321", password_confirmation: "test321"
User.create name: "tester3", password: "s3kr3t", password_confirmation: "s3kr3t"

u1 = User.where(name: "tester1").first
u2 = User.where(name: "tester2").first
u3 = User.where(name: "tester3").first

Trip.create name: "TGA2", description: "cross-country trip", user_id: u1.id
Trip.create name: "Disneyworld trip", description: "visiting Orlando for the first time", user_id: u2.id
t1 = Trip.where(user_id: u1.id, name: "TGA2").first
t2 = Trip.where(user_id: u2.id, name: "Disneyworld trip").first

Place.create name: "123 Pipers Squeak Dr."
Place.create name: "1 Disneyworld Way, Orlando, Florida"
Place.create name: "83 E Longview"
Place.create name: "kansas plains"
Place.create name: "Kansas City"
Place.create name: "Witchita"
Place.create name: "Tulsa"
Place.create name: "Denver"
Place.create name: "Rocky Mountain NP"
Place.create name: "way to Arches"
Place.create name: "Arches NP"

l_1 = Place.where(name: "123 Pipers Squeak Dr.").first
l_2 = Place.where(name: "1 Disneyworld Way, Orlando, Florida").first
l0  = Place.where(name: "83 E Longview").first 
l0b = Place.where(name: "kansas plains").first 
l1  = Place.where(name: "Kansas City").first 
l2  = Place.where(name: "Witchita").first 
l3  = Place.where(name: "Tulsa").first 
l4  = Place.where(name: "Denver").first 
l5  = Place.where(name: "Rocky Mountain NP").first 
l5b = Place.where(name: "way to Arches").first
l6  = Place.where(name: "Arches NP").first 

Route.create trip_id: t1.id, start_place: l0.id, end_place: l1.id, distance: 100
Route.create trip_id: t1.id, start_place: l1.id, end_place: l2.id, distance: 200
Route.create trip_id: t1.id, start_place: l2.id, end_place: l3.id, distance: 300
Route.create trip_id: t1.id, start_place: l3.id, end_place: l4.id, distance: 400
Route.create trip_id: t1.id, start_place: l4.id, end_place: l5.id, distance: 500
Route.create trip_id: t1.id, start_place: l5.id, end_place: l6.id, distance: 600
Route.create trip_id: t1.id, start_place: l6.id, end_place: l0.id, distance: 700
Route.create trip_id: t2.id, start_place: l_1.id, end_place: l_2.id

ro1 = Route.where(trip_id: t2.id, start_place: l_1.id, end_place: l_2.id).first

rt1 = Route.where(trip_id: t1.id, start_place: l0.id, end_place: l1.id).first
rt2 = Route.where(trip_id: t1.id, start_place: l1.id, end_place: l2.id).first
rt3 = Route.where(trip_id: t1.id, start_place: l2.id, end_place: l3.id).first
rt4 = Route.where(trip_id: t1.id, start_place: l3.id, end_place: l4.id).first
rt5 = Route.where(trip_id: t1.id, start_place: l4.id, end_place: l5.id).first
rt6 = Route.where(trip_id: t1.id, start_place: l5.id, end_place: l6.id).first
rt7 = Route.where(trip_id: t1.id, start_place: l6.id, end_place: l0.id).first

WayPlace.create name: "see the Kansas plains",  place_id: l0b.id, route_id: rt1.id
WayPlace.create name: "Glenn Canyon",            place_id: l5b.id, route_id: rt6.id
WayPlace.create name: "other things to see on the way to Arches", place_id: l5b.id, route_id: rt6.id

Activity.create name: "see Disneyworld", activity_type: at3.id, cost: 1500
Activity.create name: "trip planning", activity_type: at5.id, cost: 0, place_id: l0.id
Activity.create name: "visit Brian and Tracey", activity_type: at6.id, cost: 0, place_id: l1.id
Activity.create name: "visit brother", activity_type: at6.id, cost: 0, place_id: l2.id
Activity.create name: "visit parents", activity_type: at6.id, cost: 0, place_id:l3.id
Activity.create name: "see downtown Denver", activity_type: at3.id, cost: 0, place_id: l4.id
Activity.create name: "Holiday Inn", activity_type: at1.id, cost: 70, place_id: l4.id
Activity.create name: "Denver Zoo", activity_type: at3.id, cost: 25, place_id: l4.id
Activity.create name: "Museum of Denver history", activity_type: at3.id, cost: 15, place_id: l4.id
Activity.create name: "Rocky Mountain NP", activity_type: at3.id, cost: 20, place_id: l5.id 
Activity.create name: "Camping - Rocky Mountain NP", activity_type: at2.id, cost: 17, place_id: l5.id
Activity.create name: "see sunset", activity_type: at3.id, cost: 0, place_id: l5b.id
Activity.create name: "drive through Glen Canyon", activity_type: at3.id, cost: 0, place_id: l5b.id
Activity.create name: "Lake Powell", activity_type: at3.id, cost: 0, place_id: l5b.id
Activity.create name: "Camping - Lake Tenting resort", activity_type: at2.id, cost: 10, place_id: l5b.id
Activity.create name: "Arches NP", activity_type: at3.id, cost: 30, place_id: l6.id
Activity.create name: "Delicate Arch", activity_type: at3.id, cost: 0, place_id: l6.id
Activity.create name: "Solid Arch", activity_type: at3.id, cost: 0, place_id: l6.id
Activity.create name: "Lonely Arch", activity_type: at3.id, cost: 0, place_id: l6.id
Activity.create name: "view.. ahh.. the best.. with cows!", activity_type: at3.id, cost: 0, place_id: l0b.id



