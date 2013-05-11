module RoutesHelper

  def calc_distance(from_place_name, to_place_name)
    return 257
  end
  
  def make_route_id(trip, route)
     return "rt#{trip.id}-#{route.id}"
  end
end
