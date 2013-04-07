module PlacesHelper

  def get_route_segment(place_id)
    segments = []
    start_segment = nil
    end_segment = nil
    WayPlace.where(place_id: place_id).each do |wp|
      if wp.place_kind == "start_place"
        start_segment = "START route: #{route_name_wp(wp.id)}"
      elsif wp.place_kind == "end_place"
        end_segment = "END of route: #{route_name_wp(wp.id)}"
      else
        segments << "ON route: #{route_name_wp(wp.id)}"
      end
    end
    segments.unshift(start_segment)
    segments.append(end_segment)
    return segments
  end

  def place_name(place_id)
    Place.find(place_id).name
  end

  def trip_unassigned_places(trip_id)
    route_places = []
    Route.where(trip_id: trip_id).each do |rt|
      route_places.concat rt.places.all
    end
    return Place.where(trip_id: trip_id).reject {|item| route_places.index(item)}
  end
end
