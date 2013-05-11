module RoutesHelper

  def calc_distance(from_place_name, to_place_name)
    return 257
  end
  
  def make_route_id(trip, route)
     return "rt#{trip.id}-#{route.id}"
  end

  def get_route_driving_time(route)
    if route.notes && route.notes.match(/Driving Time/)
      return route.notes.scan(/Driving Time.*$/)[0][14..-1]
    end    
  end
end
