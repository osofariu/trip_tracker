module WayPlacesHelper
  def route_name_wp (way_place_id)
    wp = WayPlace.find(way_place_id)
    return route_name_rt(wp.route_id)
  end
end
