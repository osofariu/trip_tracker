module WayPlacesHelper
  
  def get_route_description(route_id)
    start_place_name=Place.find(Route.find(route_id).start_place).name
    end_place_name = Place.find(Route.find(route_id).end_place).name
    return "#{start_place_name} to #{end_place_name}"
  end

  def build_route_description
    Route.all.collect do |route|
      [get_route_description(route.id), route.id]
    end
  end

  def get_place_name(place_id)
    Place.find(place_id).name
  end

end
